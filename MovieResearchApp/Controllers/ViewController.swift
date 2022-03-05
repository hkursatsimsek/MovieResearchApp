//
//  ViewController.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 6.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkMonitor.shared.isConnected {
            print("You're connected")
        } else {
            print("You're not connected")
        }
    }


}

