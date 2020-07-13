//
//  CategoryVC.swift
//  Instafeed
//
//  Created by gulam ali on 09/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories = [categorytabdata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        getCategories()
    }
    
    
    //MARK:>>>> API CALL
    fileprivate func getCategories(){
        let uurl = ServerURL.firstpoint + ServerURL.categoryTab
        networking.MakeRequest(Url: uurl, Param: nil, vc: self) { (result:categorytab) in
            print(result)
            if result.message == "success"{
                guard let response = result.data else {return}
                self.categories = response.map{$0}
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }

    deinit {
        print("categoryvc removed")
    }

}

extension CategoryVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! categorycell
        cell.title.text = categories[indexPath.row].name
        cell.subtitle.text = categories[indexPath.row].description
        
//        let img = categories[indexPath.row].image
//        let imgurl = URL(string: img ?? "")
//        //let placeholder = UIImage(named: "proo")
//        cell.bg_img.contentMode = .scaleAspectFill
//        cell.bg_img.sd_setImage(with: imgurl, placeholderImage: placeholder, options: .progressiveLoad, context: nil)

        
        return cell
    }
    
    //delegate flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  15
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.6)
    }
    
    
}
