//
//  FilterViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 25/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController ,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var filtercollection: UICollectionView!
    
    var userfilterviewArray = [[String : AnyObject]]()
    var filterviewArray = [[String : AnyObject]]()

    var filterbrandviewArray = NSArray()
    var filtershapeviewArray = NSArray()
    var filtersizeviewArray = NSArray()
    
    
    var dittoid = "" ,token = "" , mnumber = "" , filtertype = "shape"


    override func viewDidLoad() {
        super.viewDidLoad()

      
        filtercollection.dataSource = self
        filtercollection.delegate = self
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "dittoid") {
            dittoid = stringOne
        }
        if let stringTwo = defaults.string(forKey: "token") {
            token = stringTwo
        }
        
        if let stringThree = defaults.string(forKey: "mobileno") {
            mnumber = stringThree
        }
        
        gotouserfilterAPI()
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            print("Swipe Left")
            if filtertype == "shape" {
                
                filtertype = "brand"
                self.filtercollection.reloadData()

            }else if filtertype == "brand" {
                
                filtertype = "size"
                self.filtercollection.reloadData()
                
            }
            
        }
        
        if (sender.direction == .right) {
            print("Swipe Right")
            if filtertype == "brand" {
                
                filtertype = "shape"
                self.filtercollection.reloadData()

                
            }else if filtertype == "size" {
                
                filtertype = "brand"
                self.filtercollection.reloadData()
            }
           
        }
    }
    
    
    @IBAction func frameshape(_ sender: Any) {
        
        filtertype = "shape"
        self.filtercollection.reloadData()

        
    }
    
    
    @IBAction func brand(_ sender: Any) {
        filtertype = "brand"
        self.filtercollection.reloadData()

        
    }
    
    @IBAction func framesize(_ sender: Any) {
        filtertype = "size"
        self.filtercollection.reloadData()

    }
    

    @IBAction func clearFilter(_ sender: Any) {
        gotoClearfilterAPI()
    }
    
    
    func gotouserfilterAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)getUserfilter?mobile=\(intnumebr)"
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        let posts = json["success"] as? [[String: Any]] ?? []
                        self.gotogetfiltersAPI()
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    func gotogetfiltersAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)getfilter?mobile=\(intnumebr)"
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        let data = json["success"] as? [String: Any]
                        let filters = data!["filters"] as? [String: Any]

                        let brand = filters!["brand"]
                        let size = filters!["size"]
                        let shape = filters!["shape"]

                        self.filterbrandviewArray = brand as! NSArray
                        self.filtersizeviewArray = size as! NSArray
                        self.filtershapeviewArray = shape as! NSArray
                        self.filtercollection.reloadData()
                        
                        
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
            })
            
            task.resume()
            
        }
        
    }
    
    
    func gotoClearfilterAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)clearfilter?mobile=\(intnumebr)"
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    let data = json["success"] as? [String: Any]
                    self.dismiss(animated: true, completion: nil)
                    //self.navigationController?.dismiss(animated: true, completion: nil)

                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK:
    //MARK: Collection view Delegete and Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if filtertype == "shape" {
            return filtershapeviewArray.count
            
        }else if filtertype == "brand" {
            return filterbrandviewArray.count
            
        }else if filtertype == "size" {
            
            return filtersizeviewArray.count
        }else {
            return filtershapeviewArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> UIEdgeInsets{
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
        //  return CGSize(width: (collectionView.frame.size.width - 30 ) / 2 , height: (UIScreen.main.bounds.size.height * (180/667)) + 15)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath.section , indexPath.row ,collectionView.tag)
        
        // get a reference to our storyboard cell
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterui", for: indexPath as IndexPath) as! FilterUIViewController
        
        if filtertype == "shape" {
            cell.imageframe.isHidden = false
            let name = ((filtershapeviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name
            if(name == "Aviator"){
                cell.imageframe.image = UIImage(named: "aviator.png")
            }else if(name == "Cat Eye"){
                cell.imageframe.image = UIImage(named: "cat_eye.png")
            }else if(name == "Oval"){
                cell.imageframe.image = UIImage(named: "oval.png")
            }else if(name == "Rectangle"){
                cell.imageframe.image = UIImage(named: "rectangular.png")
            }else if(name == "Round"){
                cell.imageframe.image = UIImage(named: "rounded.png")
            }else if(name == "Sports"){
                cell.imageframe.image = UIImage(named: "sports.png")
            }else if(name == "Clubmaster"){
                cell.imageframe.image = UIImage(named: "clubmaster.png")
            }

        }else if filtertype == "brand" {
            let name = ((filterbrandviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name
             cell.imageframe.isHidden = true

        }else if filtertype == "size" {
            let name = ((filtersizeviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name
            cell.imageframe.isHidden = true


        }
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

}
