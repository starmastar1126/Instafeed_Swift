//
//  AudioRecording.swift
//  Instafeed
//
//  Created by gulam ali on 26/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AudioRecording: UIViewController {
    
    
    @IBOutlet weak var gifimageview: UIImageView!
    
    
    @IBOutlet weak var timerlbl: UILabel!
    @IBOutlet weak var pauseplay_btnotlt: UIButton!
    
    var seconds = 1 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    var typeofrecording = ""
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var bombSoundEffect: AVAudioPlayer?
    var audioFileURL:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeofrecording = "record"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkPermissions()
    }
    
    
    //MARK:>>>> PERMISSIONS
    
    
    func checkPermissions(){
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        // self.loadRecordingUI()
                    } else {
                        // failed to record!
                        // ask for permission boi
                        self.deepLinktoaudio()
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    func deepLinktoaudio(){
        let alert = UIAlertController(title:"Need Your permission", message: "To assist you better we need your recording permission,Please allow permission", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { (alertaction) in
            print("ahjgjkahfjkdahfildfj")
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=MICROPHONE/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //recording sto or play
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
           // recordbtn.setTitle("Tap to Stop", for: .normal)
            //startd recording tap to stop btn setup
            gifimageview.loadGif(name: "wave")
            typeofrecording = "pause"
            pauseplay_btnotlt.setImage(UIImage(named: "pausee"), for: .normal)
            audioFileURL = audioFilename
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            //recordbtn.setTitle("Tap to Re-record", for: .normal)
           // pauseplay_btnotlt.backgroundColor = .green
            pauseplay_btnotlt.setImage(UIImage(named: "play"), for: .normal)
            typeofrecording = "play"
        } else {
            pauseplay_btnotlt.backgroundColor = .black
            // recording failed :(
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func playrecordedAudio(){
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: audioFileURL)
            bombSoundEffect?.play()
            print("ayan ths is duration -> \(bombSoundEffect?.duration)")
        } catch {
            // couldn't load file :(
            print("cant paly audio file")
        }
    }
    
    fileprivate func recodedAudiopLAY(){
    playrecordedAudio()
    guard let originaldata = NSData(contentsOf: audioFileURL) else {
    return
    }
    print("File size before compression: \(Double(originaldata.length / 1048576)) mb")
    
    let comp = Double(originaldata.length / 1048576)
   // beforecompress.text = "\(comp)"
    
    //compression code
    let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".m4a")
    compressAudio(inputURL: audioFileURL, outputURL: compressedURL) {[weak self] (exportSession) in
    guard let session = exportSession else {
    return
    }
    
    switch session.status {
    case .unknown:
    break
    case .waiting:
    break
    case .exporting:
    break
    case .completed:
    guard let compressedData = NSData(contentsOf: compressedURL) else {
    return
    }
    print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
    let after = Double(compressedData.length / 1048576)
    DispatchQueue.main.async {
   // self?.aftercompress.text = "\(after)"
    }
    
    
    case .failed:
    break
    case .cancelled:
    break
    @unknown default:
    break
    }
    }
    
    }
    
    
    //MARK:>>>>> Compress audio file
    func compressAudio(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
            handler(nil)
            return
        }

        exportSession.outputURL = outputURL
        
        exportSession.outputFileType = AVFileType.mov
        
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)  //might be tis call on main thread
        }
    }
    
    //MARK:>>>>>>> TIMER
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        timerlbl.text = timeString(time: TimeInterval(seconds))
    }
    
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60  //”%02i:%02i:%02i”
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }


    @IBAction func deleteTapped(_ sender: Any) {
        //reset everything
        navigationController?.popViewController(animated: false)
    }
    
    
    
    @IBAction func checktapped(_ sender: Any) {
        if audioFileURL != nil{
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name(NotificationKeys.ticktapped), object: nil)
            navigationController?.popViewController(animated: false)
        }
    }
    
    
    @IBAction func pause_play_tapped(_ sender: Any) {
        if typeofrecording == "record"{
            //start timer
            if isTimerRunning == false {
                runTimer()
            }
            pauseplay_btnotlt.setImage(UIImage(named: "pausee"), for: .normal)
            recordTapped()
        }else if typeofrecording == "pause"{
            print("pausecase")
            gifimageview.loadGif(name: "")
            //stop the timer and stop recording
            recordTapped()
            if self.resumeTapped == false {
                timer.invalidate()
                self.resumeTapped = true
            } else {
                runTimer()
                self.resumeTapped = false
            }
        }else if typeofrecording == "play"{
            gifimageview.loadGif(name: "wave")
            recodedAudiopLAY()  //for play
        }
    }

    
    
    deinit {
        print("audiorecordingvc removed")
    }
   

}


extension AudioRecording : AVAudioRecorderDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}


//self.imageView.loadGif(name: "whitegig")
