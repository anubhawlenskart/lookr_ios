//
//  CollectionViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit


class CollectionViewController: BaseViewController ,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, CollectionimageViewCellDelegate {
    
    @IBOutlet weak var collectionviewLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var share: UIImageView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet var viewOutlet: UIView!
    
    var dittoid = "" ,token = "" , mnumber = "", filterglassstring="Sunglasses" ,sku = ""
    var products = "" , newsetsku = ""
    var collectionviewArray = [[String : AnyObject]]()
    
    private var indexOfCellBeforeDragging = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapshare = UITapGestureRecognizer(target: self, action: #selector(CollectionViewController.tappedmeshare))
        let tapback = UITapGestureRecognizer(target: self, action: #selector(CollectionViewController.tappedMeback))
        back.addGestureRecognizer(tapback)
        back.isUserInteractionEnabled = true
        share.addGestureRecognizer(tapshare)
        share.isUserInteractionEnabled = true
        collectionview.dataSource = self
        collectionview.delegate = self
        
        collectionviewLayout.minimumLineSpacing = 0

       // viewOutlet.layer.backgroundColor = LookrConstants.sharedInstance.bgcolor.cgColor

        
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
        
        getcomparisonproduct()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
    
    
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        
        let buttonWidth: CGFloat = 50
        
        let inset = (collectionviewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectionviewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionviewLayout.itemSize = CGSize(width: collectionviewLayout.collectionView!.frame.size.width - inset * 2, height: collectionviewLayout.collectionView!.frame.size.height)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionviewLayout.itemSize.width
        let proportionalOffset = collectionviewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(collectionviewArray.count - 1, index))
        return safeIndex
    }
    
    
    func getcomparisonproduct(){
        self.showLoader()
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
                self.hideLoader(removeFrom: self.view)
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        
                        let data = json["success"] as? [String: Any]
                        let posts = data?["products"] as? [[String: AnyObject]]
                        self.collectionviewArray = posts!
                        self.collectionview.reloadData()
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    func getdeletecomparison(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)setcomparisonproduct?mobile=\(intnumebr)&dittoid=\(dittoid)&sku=\(newsetsku)"
            
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
                        self.getcomparisonproduct()
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    
    @objc func tappedMeback(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedmeshare()
    {
        let popOverVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "shareui") as! ShareCollectionViewController
        navigationController?.present(popOverVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionviewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth: CGFloat = flowLayout.itemSize.width
        let cellSpacing: CGFloat = flowLayout.minimumInteritemSpacing
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        var collectionWidth = collectionView.frame.size.width
        if #available(iOS 11.0, *) {
            collectionWidth -= collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        }
        let totalWidth = cellWidth * cellCount + cellSpacing * (cellCount - 1)
        if totalWidth <= collectionWidth {
            let edgeInset = (collectionWidth - totalWidth) / 2
            return UIEdgeInsets(top: flowLayout.sectionInset.top, left: edgeInset, bottom: flowLayout.sectionInset.bottom, right: edgeInset)
        } else {
            return flowLayout.sectionInset
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath as IndexPath) as! CollectionimageViewCell
        
        let sku = ((collectionviewArray[indexPath.row] as AnyObject).value(forKey: "sku") as! String)
        let fimage = ((collectionviewArray[indexPath.row] as AnyObject).value(forKey: "image") as! String)
        
        let brand = ((collectionviewArray[indexPath.row] as AnyObject).value(forKey: "brand") as! String)
        
        cell.sku.text=sku
        cell.delegate = self
        cell.skuNumber = Int(sku) ?? 0
        cell.brandname.text = brand
        
        let skuurl = URL(string: "https://d1.lk.api.ditto.com/comparison/?ditto_id="+dittoid+"&product_id="+sku)
        
        let data = try? Data(contentsOf: skuurl!)
        let task = URLSession.shared.dataTask(with: skuurl!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                cell.imageview.image = UIImage(data: data)
            }
        }
        
        let furl = URL(string: fimage)
        let fdata = try? Data(contentsOf: furl!)
        let ftask = URLSession.shared.dataTask(with: furl!) { fdata, response, error in
            guard let fdata = fdata, error == nil else { return }
            
            DispatchQueue.main.async() {    // execute on main thread
                cell.framsimage.image = UIImage(data: fdata)
            }
        }
        task.resume()
        ftask.resume()
            
        return cell
    }
    
    
    func didDeleteSKU(_ sku: Int) {
        collectionviewArray.forEach { (product) in
            let skuString = String(sku)
            if let existingSKU = product["sku"] as? String {
                if existingSKU != skuString {
                    newsetsku = newsetsku + "\(existingSKU),"
                }
            }
        }
        newsetsku.removeLast()
        getdeletecomparison()
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < collectionviewArray.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionviewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionviewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
