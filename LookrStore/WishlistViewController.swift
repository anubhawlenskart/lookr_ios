//
//  WishlistViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class WishlistViewController : BaseViewController ,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var fullimage: UIImageView!
    @IBOutlet weak var wishlistview: UICollectionView!

    @IBOutlet weak var skuname: UILabel!
    @IBOutlet weak var brandname: UILabel!
    
    var dittoid = "" ,token = "" , mnumber = "", filterglassstring="Sunglasses"
    
    var subFreamsArray = NSArray()
    var subeyeglassesArray = NSArray()

    @IBOutlet weak var liftbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        wishlistview.delegate = self
        gotocomparisonAPI()
        // Do any additional setup after loading the view.
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func collection(_ sender: Any) {
        
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "collectionui") as! CollectionViewController
            self.present(balanceViewController, animated: true, completion: nil)
            
        }
    }
    

    @IBAction func leftbutton(_ sender: Any) {
        
        
    }
    
    
    @IBAction func rightbutton(_ sender: Any) {
        
        
    }
    
    @IBAction func filter(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filter") as! FilterViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    @IBAction func lablefilter(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filter") as! FilterViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    @IBAction func chnageditto(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chnageditto") as! ChnageDittoViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(balanceViewController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    func gotocomparisonAPI(){
        if let intnumebr = Int(mnumber){
        let urlstring = "\(LookrConstants.sharedInstance.baseURL)getcomparisonproduct?mobile=\(intnumebr)&dittoid=\(dittoid)"
            
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
                    let str = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    
                    if let nestedDictionary = str["success"] as? [String: Any] {
                        // access nested dictionary values by key
                        let defaults = UserDefaults.standard
                        for (key, value) in nestedDictionary {
                            // access all key / value pairs in dictionary
                        
                        }
                        self.gotogetwishlistAPI()
                       
                    }
                    
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
            
        }
        
    }
    
    
    func gotogetwishlistAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)userframes?mobile=\(intnumebr)&dittoid=\(dittoid)&type=\(filterglassstring)&count=300"
            
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
                    self.subFreamsArray = posts as NSArray
                    self.wishlistview.reloadData()
                    
                    self.gotogeteyeglasseswishlistAPI()
                   
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    func gotogeteyeglasseswishlistAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)userframes?mobile=\(intnumebr)&dittoid=\(dittoid)&type=Eyeglasses&count=300"
            
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
                    self.subeyeglassesArray = posts as NSArray
                    self.wishlistview.reloadData()
                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    
    
    //MARK:
    //MARK: Collection view Delegete and Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return subFreamsArray.count
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
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "freamimage", for: indexPath as IndexPath) as! WishlistImageViewController
        
       
        
        let imagePath = ((subFreamsArray[indexPath.row] as AnyObject).value(forKey: "image") as! String)
        
        let url = URL(string: imagePath)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {    // execute on main thread
                cell.image.image = UIImage(data: data)
            }
        }
        
        task.resume()
        
       
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let sku = ((subFreamsArray[indexPath.row] as AnyObject).value(forKey: "sku") as! String)
        
        self.brandname.text = ((subFreamsArray[indexPath.row] as AnyObject).value(forKey: "brand") as! String)

        self.skuname.text = ((subFreamsArray[indexPath.row] as AnyObject).value(forKey: "sku") as! String)

        let url = URL(string: "https://d1.lk.api.ditto.com/comparison/?ditto_id="+dittoid+"&product_id="+sku)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {    // execute on main thread
                self.fullimage.image = UIImage(data: data)
            }
        }
        
        task.resume()

    }
    


}
