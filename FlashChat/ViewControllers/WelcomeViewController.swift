//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/22/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        runLogoAnimation()
    }
    
    func runLogoAnimation() {
        var charIndex = 0.0
        titleLabel.text = ""
        let titleText = K.appName
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }


}

