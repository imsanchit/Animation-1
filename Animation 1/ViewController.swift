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
            var index = 0
            UIView.animate(withDuration: 10, delay: 1, options: .curveEaseIn, animations:{ () -> Void in
                if index == 4 {
                    index=0
                }
                self.drawView.startAnimation(index: index)
                index += 1
        }, completion: nil)
        
    }
    
    @IBAction func stopAnimation(_ sender: UIButton) {
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
