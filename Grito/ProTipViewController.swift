//
//  ProTipViewController.swift
//  Grito
//
//  Created by Matthew Waller on 8/25/15.
//  Copyright (c) 2015 Matthew Waller. All rights reserved.
//

import Foundation
import UIKit



class ProTipViewController: UIViewController {
    
    @IBOutlet weak var proTipLabel: UILabel!
    
    var proTipText: String!
    
    var textFont: UIFont!
    
    var delegate: ProTipViewDelegate!
    
    override func viewDidLoad() {
        
    proTipLabel.text = proTipText
    
    proTipLabel.font = textFont
        
        super.viewDidLoad()
        
    }
    @IBAction func exit(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.delegate.viewDismissed(self)
    }
}

protocol ProTipViewDelegate {
    func viewDismissed(infoView: ProTipViewController)
}