//
//  ViewController.swift
//  ProgressBar
//
//  Created by Kusal Shrestha on 2/3/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = 0
    }
    
    @IBAction func progressAction(sender: AnyObject) {
        progressView.setProgress(0.75, animated: true)
    }
    
}
