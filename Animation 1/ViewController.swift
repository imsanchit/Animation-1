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
////        UIView.animate(withDuration: 4, animations: { () -> Void in
//            UIView.animate(withDuration: 10, delay: 0.4, options: [],
//                           animations: {
//                            self.drawView.transform = .concatenating(<#T##CGAffineTransform#>)
//            }            )//
////        })
    }
    
    @IBAction func stopAnimation(_ sender: UIButton) {
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
