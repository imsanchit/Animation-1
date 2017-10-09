//
//  ViewController.swift
//  Animation 1
//
//  Created by Sanchit Mittal on 04/10/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    @IBAction func startAnimation(_ sender: UIButton) {
        drawView.startAnimation()
    }
    
    @IBAction func stopAnimation(_ sender: UIButton) {
        drawView.stopAnimation()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
