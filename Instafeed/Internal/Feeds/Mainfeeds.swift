//
//  Mainfeeds.swift
//  Instafeed
//
//  Created by gulam ali on 12/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
import CoreLocation
import GooglePlaces
import GoogleMaps


class Mainfeeds: UIViewController {
    
    
    
    @IBOutlet weak var singleimagetopost: UIImageView!
    
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var draftbtn_otlt: UIButton!
    @IBOutlet weak var feedbtn_otlt: UIButton!
    @IBOutlet weak var backgroundclrview: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var txtview: UITextView!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var collview: UICollectionView!
    
    var placeid_OBJ = ""
    let nc = NotificationCenter.default
    var SelectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    var ResizedImageto1Mb = [UIImage]()
    var locationManager = CLLocationManager()
    var feedType = "text"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtview.font = UIFont.preferredFont(forTextStyle: .headline)
        txtview.delegate = self
        txtview.isScrollEnabled = false
        txtview.text = "What's happening around you?"
        txtview.textColor = UIColor.lightGray
        
       // let image = UIImage(named: "imageName")
        profileImg.layer.borderWidth = 1.0
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.white.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        feedbtn_otlt.layer.cornerRadius = 8.0
        draftbtn_otlt.layer.cornerRadius = 8.0
        
        backgroundclrview.isHidden = true
        
        collview.delegate = self
        collview.dataSource = self
        feedType = "text"
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        checkLocationServices()
        
        
        nc.addObserver(self, selector: #selector(chnageimage), name: Notification.Name(NotificationKeys.ticktapped), object: nil)
    }
    
    @objc func chnageimage(){
        singleimagetopost.image = UIImage(named: "dfhoh")
    }
    
    
    @IBAction func crossTapped(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
//        ResizedImageto1Mb.removeAll()
//        photoArray.removeAll()
//        SelectedAssets.removeAll()
    }
    
    @IBAction func bottombar_Actions(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 10: //
            print("")
            feedType = "text"
        case 20: //
            print("gallery")
            feedType = "gallery"
           // openPhotos()
            callPhotosSheeet()
        case 30: //
            print("gif")
            
        case 40: //
            print("cam")
        case 50: //
            print("stat/poll")
        case 60: //
            print("mic")
            feedType = "mic"
            let move = storyboard?.instantiateViewController(withIdentifier: "AudioRecording") as! AudioRecording
            navigationController?.pushViewController(move, animated: false)
        case 70: //
            print("music")
        default:
            break
        }
        
    }
    
    
    
    let controller = UIImagePickerController()
    func callPhotosSheeet(){
        CommonFuncs.HitactionSheet(vc: self, title1: "Camera", title1action: {
            self.clickimage()
        }, title2: "Photos") {
            self.pickimage()
        }
        
    }
    
    //MARK:>>>> Picking Image from Gallery
    func pickimage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            controller.delegate = self
            controller.sourceType = .photoLibrary
            controller.allowsEditing = false
            present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK:>>>> Picking Image from Camera
    func clickimage(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            controller.delegate = self
            controller.sourceType = .camera
            controller.allowsEditing = false
            self.present(controller, animated: true, completion: nil)
        }else{
            print("You Dont have a CAMERA")
        }
    }
    
    
    
    
    //MARK:>>>>> Multiple photos
    fileprivate func openPhotos(){
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 5
        vc.cancelButton.tintColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        vc.doneButton.tintColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        vc.selectionCharacter = "✓"
        
        vc.selectionFillColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        vc.selectionStrokeColor = UIColor.white
        vc.selectionShadowColor = UIColor.white
        
        vc.selectionTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGray
        vc.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
            switch (verticalSize, horizontalSize) {
            case (.compact, .regular): // iPhone5-6 portrait
                return 2
            case (.compact, .compact): // iPhone5-6 landscape
                return 2
            case (.regular, .regular): // iPad portrait/landscape
                return 3
            default:
                return 3
            }
        }
        
        self.bs_presentImagePickerController(vc, animated: true, select: { (assest: PHAsset) -> Void in
        },
        deselect: { (assest: PHAsset) -> Void in
                                                
        }, cancel: { (assest: [PHAsset]) -> Void in
            
        }, finish: { (assest: [PHAsset]) -> Void in
            
            for i in 0..<assest.count
            {
                self.SelectedAssets.append(assest[i])
            }
            
            self.convertAssetToImages()
            
        }, completion: nil)

    }
    
    
    func convertAssetToImages() -> Void {
        
        if SelectedAssets.count != 0{
            
            for i in 0..<SelectedAssets.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                
                var thumbnail = UIImage()
                
                option.isSynchronous = true
                
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result,info) -> Void in
                    thumbnail = result!
                })
                
                let data = thumbnail.jpegData(compressionQuality: 0.4)
                let newImage = UIImage(data: data!)
              let resizedimageto1MB = newImage?.resizedTo1MB()
                self.photoArray.append(newImage! as UIImage)
                self.ResizedImageto1Mb.append(resizedimageto1MB! as UIImage)
                
            }
            
//            self.images.animationImages = self.photoArray
//            self.images.animationDuration = 3.0
//            self.images.startAnimating()  //to animate images
            
            DispatchQueue.main.async {
                self.collview.reloadData()
            }
            
        }
        
    }
    
    @IBAction func buttons_tapped(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 100: //
            print("privacy")
            let move = storyboard?.instantiateViewController(withIdentifier: "PrivacyVC") as! PrivacyVC
            navigationController?.pushViewController(move, animated: true)
        case 200: //
            print("location")
//            let move = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
//            navigationController?.pushViewController(move, animated: true)
            presentAutocomplete()
        default:
            break
        }
        
    }
    
    
    //MARK:>>>. CLocation setup
    //MARK:>>>>>> Core Location setup
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            print(location)
            UserCurrentLocation = (locationManager.location?.coordinate)!
            print(UserCurrentLocation)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            print("user turned off the permission")
            AskPermissionForcefully()
        }
    }
    
    
    func AskPermissionForcefully(){
        let alert = UIAlertController(title:"Need Your Location", message: "To assist you better we need your location permission,Please allow permission", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { (alertaction) in
            print("ahjgjkahfjkdahfildfj")
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            AskPermissionForcefully()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        default:
            break
        }
    }
    

    
    //MARK:>>>>> Feeds Tapped
    @IBAction func feedsTapped(_ sender: Any) {
        if feedType == "text"{
           //only text is about to post
           postTextcheck()
        }else if feedType == "mic"{
            //audio recorded
            AudioPost()
        }else if feedType == "gallery"{
            postImage()
        }
        
    }
    
    
    private func postImage(){
        if txtview.text == "" || txtview.text == "What's happening around you?"{
            CommonFuncs.AlertWithOK(msg: "Please write something", vc: self)
            return
        }else{
            //post image
            let api = ServerURL.firstpoint + ServerURL.feedPost
            guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
            if placeid_OBJ == ""{
                CommonFuncs.AlertWithOK(msg: "Please select a location", vc: self)
                return
            }else{
                print("good to go bro")
            }
            let params = ["token":UserToken,"title":txtview.text!,"description":txtview.text!,"location_id":placeid_OBJ,"lat":UserCurrentLocation.latitude,"long":UserCurrentLocation.longitude,"mod":"n","is_an":"n","lang_id":"EN"] as [String:Any]
            
            print(params)
            
            networking.uploadImagesAndData(Api: api, params: params, imagepost: singleimagetopost.image!) { (result, err) in
                if err != nil{
                    CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                    return
                }
                else{
                    guard let msg = result?.message else {return}
                    if msg == "success"{
                         CommonFuncs.AlertWithOK(msg: "Successfully Posted", vc: self)
                        self.txtview.text = "What's happening around you?"
                        self.txtview.textColor = UIColor.lightGray
                        self.singleimagetopost.image = UIImage(named: "")
                        return
                    }else{
                        CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                        return
                    }
                }
            }
            
        }
    }
    
    
    private func AudioPost(){
        if txtview.text == "" || txtview.text == "What's happening around you?"{
            CommonFuncs.AlertWithOK(msg: "Please write something", vc: self)
            return
        }else{
            //post audio
            postAudio()
        }

    }
    
    fileprivate func postAudio(){
        //let params = [:] as [String:Any]
        
        //let url = ServerURL.firstpoint + ServerURL.feedPost
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        
        /*
         if cam is envoked then mode has Y
         if location is saving or getting the is_an is y
         */
        
        if placeid_OBJ == ""{
            CommonFuncs.AlertWithOK(msg: "Please select a location", vc: self)
            return
        }else{
            print("good to go bro")
        }
        
        /*
         token,title,category_id,description,image,
         image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,video,video1,
         video2,video3,video4,video5,video6,video7,video8,video9,video10,audio,audio1,audio2,
         audio3,audio4,location_id,lat,long,mod={y,n default is n},is_an={Y,N},lang_id
         */
        
        //gurad let audioFile = RecordedAudio else {return}
        
        let params = ["token":UserToken,"title":txtview.text!,"description":txtview.text!,"location_id":placeid_OBJ,"lat":UserCurrentLocation.latitude,"long":UserCurrentLocation.longitude,"mod":"n","is_an":"n","lang_id":"EN","audio":""] as [String:Any]
        
        print(params)
        
        
        
    }
    
    private func postTextcheck(){
        if txtview.text == "" || txtview.text == "What's happening around you?"{
            CommonFuncs.AlertWithOK(msg: "Please write something", vc: self)
            return
        }else{
            if ResizedImageto1Mb.count == 0{
                postOnlyText()
            }
            
        }
    }
    
    //MARK:>>> Autocomplete view controller
    func presentAutocomplete(){
       // textField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        let countryFilter = GMSAutocompleteFilter()
       // countryFilter.country = "IN"
        acController.autocompleteFilter = countryFilter
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    
    
    //MARK:>>>>> API calls
    fileprivate func postOnlyText(){
        let url = ServerURL.firstpoint + ServerURL.feedPost
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        
        /*
         if cam is envoked then mode has Y
         if location is saving or getting the is_an is y
         */
        
        if placeid_OBJ == ""{
            CommonFuncs.AlertWithOK(msg: "Please select a location", vc: self)
            return
        }else{
            print("good to go bro")
        }
    
        let params = ["token":UserToken,"title":txtview.text!,"description":txtview.text!,"location_id":placeid_OBJ,"lat":UserCurrentLocation.latitude,"long":UserCurrentLocation.longitude,"mod":"n","is_an":"n","lang_id":"EN"] as [String:Any]
        
        print(params)
        
        networking.MakeRequest(Url: url, Param: params, vc: self) { (result:postfeed) in
            if result.message == "success"{
                //successfully posted textual data
                CommonFuncs.AlertWithOK(msg: "Successfully posted", vc: self)
                self.txtview.text = "What's happening around you?"
                self.ResizedImageto1Mb.removeAll()
                self.photoArray.removeAll()
                self.SelectedAssets.removeAll()
                DispatchQueue.main.async {
                    self.collview.reloadData()
                }
                return
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
        
        
    }
    
    
    //fileprivate func postImage(){}
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nc.removeObserver(NotificationKeys.ticktapped)
    }
    
    deinit {
        print("mainfeeds removed")
    }

}

extension Mainfeeds : UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
       // print(textView.text)
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedHeight = textView.sizeThatFits(size)
        textView.constraints .forEach { (constrain) in
            if constrain.firstAttribute == .height{
                
                constrain.constant = estimatedHeight.height
                
                
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening around you?"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension Mainfeeds : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ResizedImageto1Mb.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postcell", for: indexPath) as! postcell
        cell.postimage.image = ResizedImageto1Mb[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collview!.bounds.width, height: collview!.bounds.height) // You can change width and height here as pr your requirement
        
    }
    
    
}

//MARK:>>>> CLLocation delegates

extension Mainfeeds : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        UserCurrentLocation = manager.location!.coordinate
       // print(UserCurrentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}

//MARK:>>>> GMSAutocomplete delegates

extension Mainfeeds : GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("this is your selected loc palecid ->",place.placeID!)
        print("place name is->",place.name!)
        locationlbl.text = place.name!
        placeid_OBJ = place.placeID!
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error while placesAUTOCOMPLETE: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension Mainfeeds : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        let resizeimage = image.resizedTo1MB()

        
       singleimagetopost.image = resizeimage
        
        //profilepic.contentMode = .scaleToFill
        
        dismiss(animated: true, completion: nil)
    }
}

