//
//  ViewController.swift
//  Grito
//
//  Created by Matthew Waller on 8/20/15.
//  Copyright (c) 2015 Matthew Waller. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, InfoViewDelegate {

    @IBOutlet weak var getGritosButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    var darkView: UIView!
    
    var infoText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        getGritosButton.layer.cornerRadius = 28
        
        getGritosButton.layer.borderColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(8.0/255.0), blue: CGFloat(181.0/255.0), alpha: 1.0).CGColor
        
        getGritosButton.layer.borderWidth = 4
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "SymphonyBackgroundWhite2.png")!)
        
        let newTitleFont = (UIScreen.mainScreen().bounds.width * 13)/320
        
        textView.font = UIFont(name: "Signika-Semibold", size: newTitleFont)
        
        
        
        
        
        infoText = "We hope you love ¡Grito! as much as we do. This is an app created by a bunch of Tejanos who appreciate their roots and want to share this piece of our culture with you!\n" +
            
            "\n" +
        
            "All of the recorded grito-ers are native Austinites who love to belt it out at family gatherings and such and we’re grateful to them for lending us their hearts and lungs!\n" +
        
            "\n" +
                
            "We promise we will never spam you or share your info, but we’re going to have some exciting updates with the app that you’ll want to know about, so join our mailing list!"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("hasOpenedBefore") {
            informationButton(infoButton)
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasOpenedBefore")
            
            
        }
        
    }

    @IBAction func informationButton(sender: UIButton) {
        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let infoViewController: InformationViewController = storyboard.instantiateViewControllerWithIdentifier("InformationViewController") as! InformationViewController
        
        let textView = UITextView(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.view.frame.size.width-32, height: CGFloat.max)))
        
        let newTitleFont = (UIScreen.mainScreen().bounds.width * 12)/320

        
        textView.font = UIFont(name: "Signika-Regular", size: newTitleFont)
        
        textView.text = infoText
        //textView.scrollEnabled = false
        
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.max))
        
        var newSizeOffset = CGFloat(162)
        
        if UIScreen.mainScreen().bounds.height == 1024 {
            newSizeOffset = 198
        }
    
        
        infoViewController.preferredContentSize = CGSize(width: self.view.frame.size.width-32, height: newSize.height + newSizeOffset)
        
        infoViewController.informationText = infoText
        
        infoViewController.textFont = UIFont(name: "Signika-Regular", size: newTitleFont)
        
        infoViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        infoViewController.delegate = self
        
        let popoverInfoViewController = infoViewController.popoverPresentationController
        

        popoverInfoViewController?.permittedArrowDirections = UIPopoverArrowDirection()
        popoverInfoViewController?.delegate = self
        popoverInfoViewController?.sourceView = self.view
        popoverInfoViewController?.sourceRect = self.view.frame
        presentViewController(infoViewController, animated: true, completion: nil)
        
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
    

    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {

        
    }
    
    func viewDismissed(infoView: InformationViewController) {
        darkView.removeFromSuperview()
    }
    
}

