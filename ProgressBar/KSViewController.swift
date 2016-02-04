//
//  ViewController.swift
//  ProgressBar
//
//  Created by Kusal Shrestha on 1/25/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class KSViewController: UIViewController {
    
    var progressView: KSProgressView!
    @IBOutlet var progressPlaceholder: UIView!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView = KSProgressView(frame: self.progressPlaceholder.bounds, color: UIColor.redColor())
        progressView.numberOfSteps = 4
        self.progressPlaceholder.addSubview(progressView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        progressView.frame = self.progressPlaceholder.bounds
    }

    @IBAction func buttonAction(sender: AnyObject) {
        counter = counter + 1
        if counter > progressView.numberOfSteps {
            counter = 0
        }
        progressView.setProgress(counter)
    }

}

