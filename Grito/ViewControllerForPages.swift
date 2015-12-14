//
//  ViewControllerForPages.swift
//  Grito
//
//  Created by Matthew Waller on 8/20/15.
//  Copyright (c) 2015 Matthew Waller. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerForPages: UIViewController, UIPageViewControllerDataSource, AudioPlayDelegate, AVAudioPlayerDelegate, UIPageViewControllerDelegate {
    
    
    var pageViewController: UIPageViewController!
    
    var pageTitles: NSArray!
    
    var pageTexts: NSArray!
    
    var pageImages: NSArray!
    
    var pageSounds: NSArray!
    
    var buttonColors: NSArray!
    
    var backgroundColors: NSArray!
    
    var gritoImages: NSArray!
    
    var protips: NSArray!
    
    var audioPlayer: AVAudioPlayer!
    
     var url: NSURL!
    
    var currentPage: Int!
    
    var activityController: UIActivityViewController!
    
    
    override func viewDidLoad()
        
    {
        
        super.viewDidLoad()
        
        
        //self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageTitles = NSArray(objects: "Whisto", "Short & Sweet", "¡Hechale!","¡Grrrrrito!","Pajaro")
        
        let para1 = "If you’re going to start a grito on or around Diez y Seis, have a drink or two or three and then cry out the following in this order: \n" +
            "\n" +
            "\"¡Mexicanos! ¡Vivan los héroes que nos dieron patria! ¡Viva Hidalgo! ¡Viva Morelos! ¡Viva Josefa Ortiz de Domínguez! ¡Viva Allende! ¡Vivan Aldama y Matamoros! ¡Viva la independencia nacional! ¡Viva México! ¡Viva México! ¡Viva México!\"\n" +
            "\n" +
            "After each proclamation, the crowd of your compañeros should holler out \"¡Viva!\" in response. This will get the party roaring!"
        
       let para2 = "Remember, you don’t have to reserve your grito for Diez y Seis. Whenever you feel compelled to holler out with great emotion (excitement or sadness, typically), let the grito be your instrument. Especially at a party. Especially when mariachis start to play. Dig down deep into your diaphragm and belt it out, holding the first sound for as long as possible and then end in a set of trailing trills. Free therapy, you guys!"
        
        let para3 = "In rural areas, it is common for folks to fire gunshots before or after a grito. DO NOT TRY THIS AT HOME."
        
        let para4 = "You don’t have to wait for a Mariachi band to start a grito. This is a great way to greet a loved one every time they walk into the door. (Also, a great way to wake someone from a peaceful slumber!)"
        
        let para5 = "This bird whistle at the end came from a human. Our best advice to get good at whistling is to watch a bunch of Youtube “how to whistle like a bird” videos and practice in the shower!"
        
        
        self.pageSounds = NSArray(objects: "Whisto3", "ShortAndSweet3", "HechaleGrito3", "Grrrrrrito3", "Pajaro3")
        
        self.pageTexts = NSArray(objects: "Grito pro tip 1", "Grito pro tip 2", "Grito pro tip 3", "Grito pro tip 4", "Grito pro tip 5")
        
        let greenColor = UIColor(red: CGFloat(12.0/255.0), green: CGFloat(193.0/255.0), blue: CGFloat(154.0/255.0), alpha: 1.0)
        let blueColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(8.0/255.0), blue: CGFloat(181.0/255.0), alpha: 1.0)
        _ = UIColor(red: CGFloat(234.0/255.0), green: CGFloat(4.0/255.0), blue: CGFloat(69.0/255.0), alpha: 1.0)
        let yellowColor = UIColor(red: CGFloat(232.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(20.0/255.0), alpha: 1.0)
        _ = UIColor(red: CGFloat(252.0/255.0), green: CGFloat(252.0/255.0), blue: CGFloat(252.0/255.0), alpha: 1.0)
        
        self.buttonColors = NSArray(objects: yellowColor, blueColor, greenColor, yellowColor, blueColor)
        
        self.backgroundColors = NSArray(objects: UIImage(named: "SymphonyBackgroundGreen3.png")!, UIImage(named: "SymphonyBackgroundYellow2.png")!, UIImage(named: "SymphonyBackgroundBlue2.png")!, UIImage(named: "SymphonyBackgroundGreen3.png")!, UIImage(named: "SymphonyBackgroundYellow2.png")!)
        
        self.gritoImages = NSArray(objects: UIImage(named: "grito_pink_edit")!, UIImage(named: "grito_blue_edit")!, UIImage(named: "grito_yellow_edit")!,UIImage(named: "grito_pink_edit")!,UIImage(named: "grito_blue_edit")!)
        
        self.protips = NSArray(objects: para1, para2, para3, para4, para5)
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        self.pageViewController.delegate = self
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        
        let viewControllers = NSArray(object: startVC)
        
        
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height)
        
        
        
        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        
        //var error: NSError?
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:AVAudioSessionCategoryOptions.DefaultToSpeaker)
        } catch _ as NSError {
            
        }
        
        let path =  NSBundle.mainBundle().pathForResource(self.pageSounds[0] as? String, ofType: "mp4")!
        
        url = NSURL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        } catch  _ {
            //error = error1
            audioPlayer = nil
        }
        
        audioPlayer.delegate = self
        
        audioPlayer.prepareToPlay()
        
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        
        self.view.backgroundColor = UIColor(red: CGFloat(252.0/255.0), green: CGFloat(252.0/255.0), blue: CGFloat(252.0/255.0), alpha: 1.0)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
        
    {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            
            return ContentViewController()
            
        }
        
        
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        vc.buttonColor = self.buttonColors[index] as! UIColor
        
        vc.titleText = self.pageTitles[index]as! String
        
       // vc.urlText = self.pageSounds[index] as! String
        
        vc.contentText = self.pageTexts[index] as! String
        
        vc.screenColor = self.backgroundColors[index] as! UIImage
        
        vc.gritoLogo = self.gritoImages[index] as! UIImage
    
        vc.proTip = self.protips[index] as! String
        
        // = self.backgroundColors[index] as? UIColor
        
        vc.audioPlayDelegate = self
        
        vc.pageIndex = index
        
        
        
        return vc
        
        
        
        
        
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
            
            
        }
        
        
        
        index--
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        if (index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        
        
        index++
        
        
        
        if (index == self.pageTitles.count)
            
        {
            
            return nil
            
        }
        
        
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return 0
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        audioPlayer.stop()
        
    }
    
    
    func playAudio(contentViewController: ContentViewController) {
        
        let path =  NSBundle.mainBundle().pathForResource(self.pageSounds[currentPage] as? String, ofType: "mp4")!
        
        url = NSURL(fileURLWithPath: path)
        
        audioPlayer = try? AVAudioPlayer(contentsOfURL: url)
        
        audioPlayer.delegate = self
        
        audioPlayer.prepareToPlay()
        
        
        audioPlayer.play()
        
    }
    
    func share(){
        
        if UIScreen.mainScreen().bounds.height == 1024 { //if it's an ipad do this
        
            let popUp = UIPopoverController(contentViewController: activityController)
            popUp.presentPopoverFromRect(CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), inView: self.view, permittedArrowDirections: UIPopoverArrowDirection(), animated: true)
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.presentViewController(self.activityController, animated: true, completion: nil)
            }
        }
        
        
        
        //self.presentViewController(activityController, animated: true, completion: nil)
    
//    let activityViewController = UIActivityViewController(
//        activityItems: [url],
//        applicationActivities: nil)
//        
//        //activityViewController.excludedActivityTypes = [UIActivityTypeAirDrop]
//        
//    self.presentViewController(activityViewController,
//    animated: true,
//    completion: nil)
    
    }
    
    func getCurrentPageIndex(index: Int) {
        
        currentPage = index
        
        let path =  NSBundle.mainBundle().pathForResource(self.pageSounds[index] as? String, ofType: "mp4")!
        
        url = NSURL(fileURLWithPath: path)
        
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
    }
}