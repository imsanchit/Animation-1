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

    var doAnimation: Bool = false
    @IBOutlet weak var drawView: DrawView!
    
    @IBAction func startAnimation(_ sender: UIButton) {
        doAnimation = true
        drawView.startAnimation()
//        var index:Int = 0
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let strongSelf = self else { return }
//            while strongSelf.doAnimation {
//                if index == strongSelf.drawView.numberOfSections {
//                    index = 0
//                }
//                DispatchQueue.main.async {
//                    UIView.animate(withDuration: 1, animations: {
//                        strongSelf.drawView.selectedSegmentIndex = index
//                    }, completion: nil)
//                }
//                index = index + 1
//            }
//        }
    }
    
    @IBAction func stopAnimation(_ sender: UIButton) {
        doAnimation = false
        drawView.stopAnimation()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
