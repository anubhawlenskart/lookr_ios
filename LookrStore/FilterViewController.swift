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
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

      
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
        
        
        // Do any additional setup after loading the view.
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
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    let posts = json["success"] as? [[String: Any]] ?? []
                    self.gotogetfiltersAPI()
                    
                } catch let error as NSError {
                    print(error)
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
                    self.view.removeFromSuperview()

                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    
    
    @IBAction func close(_ sender: Any) {
        
        
        self.view.removeFromSuperview()
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
            let name = ((filtershapeviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name

        }else if filtertype == "brand" {
            let name = ((filterbrandviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name

        }else if filtertype == "size" {
            let name = ((filtersizeviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name

        }else {
            
            let name = ((filtershapeviewArray[indexPath.row] as AnyObject) as! String)
            cell.name.text = name

        }
        
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

}
