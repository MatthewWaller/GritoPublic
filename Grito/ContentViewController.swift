//
//  ContentViewController.swift
//  Grito
//
//  Created by Matthew Waller on 8/20/15.
//  Copyright (c) 2015 Matthew Waller. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import MediaPlayer

class ContentViewController: UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, ProTipViewDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var proTipButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var screenNumber: UIPageControl!
    
    var pageIndex: Int!
    
    var titleText: String!
    
    var contentText: String!
    
    var darkView: UIView!
    
    var audioPlayDelegate: AudioPlayDelegate!
    
    
    @IBOutlet weak var gritoImage: UIImageView!
    
    var buttonColor: UIColor!
    
    var screenColor: UIImage!
    
    var gritoLogo: UIImage!
    
    var proTip: String!
    
//    var url: NSURL!
//    
//    var urlText: String!
//    
//    var audioPlayer: AVAudioPlayer!
    
    
    
    
    override func viewDidLoad()
        
    {
        
        super.viewDidLoad()
        
        self.playButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        let newTitleFont = (UIScreen.mainScreen().bounds.width * 17)/320
        
        titleLabel.font = UIFont(name: "Signika-Regular", size: newTitleFont)

        
        self.titleLabel.text = self.titleText
        
        //set up the audio session here
     //   var error: NSError?
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:AVAudioSessionCategoryOptions.DefaultToSpeaker)
        } catch _ as NSError {
            //error = error1
        }
        
//        let path =  NSBundle.mainBundle().pathForResource(urlText, ofType: "mp4")!
//        
//        url = NSURL(fileURLWithPath: path)
//        
//        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
//        
//        audioPlayer.delegate = self
//        
//        audioPlayer.prepareToPlay()
        
        screenNumber.currentPage = pageIndex
        
        self.view.backgroundColor = UIColor(patternImage: screenColor)
        
        gritoImage.image = gritoLogo
        
        
        let origImage = UIImage(named: "GritoPlayButton3.png");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        playButton.setImage(tintedImage, forState: .Normal)
        playButton.tintColor = buttonColor
        
        proTipButton.setTitle(contentText, forState: UIControlState.Normal)
        
        proTipButton.layer.cornerRadius = 28
        
        proTipButton.layer.borderColor = UIColor(red: 252.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0).CGColor
        
        proTipButton.layer.borderWidth = 4
        
        }
    
    override func viewWillAppear(animated: Bool) {
        print("view changed")
        
        self.audioPlayDelegate.getCurrentPageIndex(pageIndex)
        
        print("\(pageIndex)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSound(sender: UIButton) {
        
        let masterVolumeSlider: MPVolumeView = MPVolumeView()
        
        if let view = masterVolumeSlider.subviews.first as? UISlider{
            
            view.value = 1.0
            
        }
        
//        if audioPlayer.playing {
//            audioPlayer.stop()
//        } else {
//        
//        audioPlayer.play()
//        }
        
            //audioPlayer.play()
        
        self.audioPlayDelegate.playAudio(self)
        
    }
    
    
    @IBAction func proTipPressed(sender: UIButton) {
        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let proTipViewController: ProTipViewController = storyboard.instantiateViewControllerWithIdentifier("ProTipViewController") as! ProTipViewController
        
        proTipViewController.proTipText = proTip
        
        let newTitleFont = (UIScreen.mainScreen().bounds.width * 12)/320
        
        proTipViewController.textFont = UIFont(name: "Signika-Regular", size: newTitleFont)
        
        let widthSubtraction = CGFloat(56)
        
        
        let textView = UITextView(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.view.frame.size.width - widthSubtraction, height: CGFloat.max)))
        
        textView.font = UIFont(name: "Signika-Regular", size: newTitleFont)
        
        textView.text = proTip
       textView.scrollEnabled = false
        
        
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.max))
        
        let newSizeOffset = CGFloat(135)
        
        
        proTipViewController.preferredContentSize = CGSize(width: self.view.frame.size.width-32, height: newSize.height + newSizeOffset) //self.view.frame.height*2/3
        proTipViewController.modalPresentationStyle = .Popover
        proTipViewController.delegate = self
        
        
        let popoverInfoViewController = proTipViewController.popoverPresentationController

        popoverInfoViewController?.permittedArrowDirections = UIPopoverArrowDirection()
        popoverInfoViewController?.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(8.0/255.0), blue: CGFloat(181.0/255.0), alpha: 1.0)
        popoverInfoViewController?.delegate = self
        popoverInfoViewController?.sourceView = self.view
        popoverInfoViewController?.sourceRect = self.view.frame
        presentViewController(proTipViewController, animated: true, completion: nil)
        
        darkView = UIView(frame: self.view.frame)
        darkView.backgroundColor = UIColor.blackColor()
        darkView.alpha = 0.6
        
        self.view.addSubview(darkView)
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    
     func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
        darkView.removeFromSuperview()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        //make the volume go back down here
    }

    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        
        
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
    
    
    @IBAction func share(sender: UIButton) {

        
       self.audioPlayDelegate.share()
        
//        let activityViewController = UIActivityViewController(
//            activityItems: [gritoLogo],
//            applicationActivities: nil)
//        self.presentViewController(activityViewController,
//            animated: true,
//            completion: nil)
        
    }
    
    func viewDismissed(infoView: ProTipViewController) {
        darkView.removeFromSuperview()
    }
    
    
}
protocol AudioPlayDelegate {
    func playAudio(contentViewController: ContentViewController)
    func share()
    func getCurrentPageIndex(index: Int)
    
}
