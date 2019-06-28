//
//  UserFreameViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

protocol WishListControllerDelegate: class {
    func didLogOut()
}

class UserFreameViewController : BaseViewController ,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var eyeglasses: UIButton!
    @IBOutlet weak var sunglasse: UIButton!
    @IBOutlet weak var fullimage: UIImageView!
    @IBOutlet weak var wishlistview: UICollectionView!
    @IBOutlet weak var skuname: UILabel!
    @IBOutlet weak var brandname: UILabel!
    @IBOutlet weak var liftbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var imageCirleView: UIView!

    
    var dittoid = "" ,token = "" , mnumber = "", filterglassstring="Sunglasses" ,sku = ""
    var indexPathmain = 0
    var subFreamsArray = NSArray()
    var subeyeglassesArray = NSArray()
    var subsunglassesArray = NSArray()
    var collectionviewArray = [[String : AnyObject]]()
    
    var wishlistedProduct = ""
    weak var delegate: WishListControllerDelegate?
    
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
        
        fullimage.layer.cornerRadius = 10
        fullimage.clipsToBounds = true
        fullimage.layer.borderWidth = 3
        fullimage.layer.borderColor = UIColor.white.cgColor
        
        wishlistview.delegate = self
    
        imageCirleView.layer.borderWidth = 2.0
        imageCirleView.layer.masksToBounds = false
        imageCirleView.layer.borderColor = LookrConstants.sharedInstance.color.cgColor
        //imageCirleView.layer.borderColor = UIColor.white.cgColor

        imageCirleView.layer.cornerRadius = imageCirleView.frame.height/2
        imageCirleView.clipsToBounds = true
        
        
        
        gotocomparisonAPI()
        
    }
    
    @IBAction func collection(_ sender: Any) {
        getsetcomparison()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "collectionui") as! CollectionViewController
        // self.present(balanceViewController, animated: true, completion: nil)
        navigationController?.pushViewController(balanceViewController, animated: true)
    }
    
    @IBAction func addToWishlistAction(_ sender: UIButton) {
        setsku(self.skuname.text ?? "")
        
    }
    
    @IBAction func sunglassesAction(_ sender: UIButton) {
        subFreamsArray = subsunglassesArray
        wishlistview.reloadData()
        setimage(0)
        
    }
    
    @IBAction func eyeglassesAction(_ sender: UIButton) {
        
        subFreamsArray = subeyeglassesArray
        wishlistview.reloadData()
        setimage(0)
    }
    
    @IBAction func setSunglasses(_ sender: Any) {
        
    }
    
    
    @IBAction func leftbutton(_ sender: Any) {
        indexPathmain -= 1
        setimage(indexPathmain)
    }
    
    
    @IBAction func rightbutton(_ sender: Any) {
        
        indexPathmain += 1
        setimage(indexPathmain)
        
    }
    
    @IBAction func filter(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shareui") as! ShareCollectionViewController
        self.navigationController?.present(popOverVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func lablefilter(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filter") as! FilterViewController
        navigationController?.present(popOverVC, animated: true, completion: nil)
        
        
        
    }
    @IBAction func chnageditto(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chnageditto") as! ChnageDittoViewController
        navigationController?.pushViewController(popOverVC, animated: true)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        delegate?.didLogOut()
        self.navigationController?.popViewController(animated: true)
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
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        let data = json["success"] as? [String: Any]
                        let posts = data?["products"] as? [[String: AnyObject]]
                        self.collectionviewArray = posts!
                        self.collectionviewArray.forEach { (product) in
                            let skuString = String(self.sku)
                            if let existingSKU = product["sku"] as? String {
                                self.wishlistedProduct.append("\(existingSKU),")
                            }
                        }
                        self.gotogetwishlistAPI()
                        self.gotogeteyeglasseswishlistAPI()
                        
                    }catch {
                        print("error")
                    }
                }
            })
            task.resume()
        }
        
    }
    
    func setsku(_ sku: String) {
        wishlistedProduct.append("\(sku),")
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
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        let posts = json["success"] as? [[String: Any]] ?? []
                        self.subFreamsArray = posts as NSArray
                        self.subsunglassesArray = posts as NSArray
                        
                        self.wishlistview.reloadData()
                        
                        self.setimage(0)
                        
                    } catch let error as NSError {
                        print(error)
                    }
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
                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    func getsetcomparison(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)setcomparisonproduct?mobile=\(intnumebr)&dittoid=\(dittoid)&sku=\(wishlistedProduct)"
            
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
                        let posts = data?["products"] as? [[String: AnyObject]]
                        
                    } catch let error as NSError {
                        print(error)
                    }
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
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "freamimage", for: indexPath as IndexPath) as! WishlistImageViewCell
        
        let imagePath = ((subFreamsArray[indexPath.row] as AnyObject).value(forKey: "image") as! String)
        
        let url = URL(string: imagePath)
        let data = try? Data(contentsOf: url!)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.image.image = UIImage(data: data)
            }
        }
        task.resume()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexPathmain = indexPath.row
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
    
    
    func setimage(_ index: Int ) {
        
        if (index > -1 && index < 300) {
            let indexpath = IndexPath(row: index, section: 0)
            if let cell = wishlistview.cellForItem(at: indexpath) as? WishlistImageViewCell {
                cell.isSelected = true
            }
            let sku = ((subFreamsArray[index] as AnyObject).value(forKey: "sku") as! String)
            self.brandname.text = ((subFreamsArray[index] as AnyObject).value(forKey: "brand") as! String)
            self.skuname.text = ((subFreamsArray[index] as AnyObject).value(forKey: "sku") as! String)
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
}
