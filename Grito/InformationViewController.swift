//
//  InformationViewController.swift
//  Grito
//
//  Created by Matthew Waller on 8/23/15.
//  Copyright (c) 2015 Matthew Waller. All rights reserved.
//

import Foundation
import UIKit
import Parse

class InformationViewController: UIViewController, UITextFieldDelegate, UIPopoverControllerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var submitConstraint: NSLayoutConstraint!
    
    var textFont: UIFont!
    
    var informationText: String!
    
    var delegate: InfoViewDelegate!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
        informationLabel.text = informationText
        
        informationLabel.font = textFont
         
        
    }
    
    
    
    @IBAction func emailButtonPressed(sender: UIButton) {
        
        if emailTextField.text != "" {
        
        let submittedEmail = PFObject(className: "Emails")
        
        submittedEmail["address"] = emailTextField.text
        
        submittedEmail.saveInBackground()
        
        emailTextField.text = ""
            
        emailTextField.placeholder = "Thanks!"
            
        }
        
        textFieldShouldReturn(emailTextField)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    @IBAction func exit(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.delegate.viewDismissed(self)
        
    }

    
}

protocol InfoViewDelegate {
    func viewDismissed(infoView: InformationViewController)
}