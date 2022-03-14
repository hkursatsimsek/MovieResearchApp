//
//  SplashVC.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 6.03.2022.
//

import UIKit
import FirebaseRemoteConfig

class SplashVC: BaseViewController {

    @IBOutlet weak var lblSplashText: UILabel!
    private let remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if NetworkMonitor.shared.isConnected {
            setupRemoteConfigDefaults()
            fetchRemoteConfig()
        } else {
            let alertController = UIAlertController(title: "Warning",
                                                    message: "You need an active internet connection to continue.",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension SplashVC {
    
    func setupRemoteConfigDefaults() {
        let defaults : [String : NSObject] = [
            "splash_text" : "Default Value" as NSObject
        ]

        self.remoteConfig.setDefaults(defaults)
    }
    
    func displayNewValue() {
        let newLabelText = self.remoteConfig.configValue(forKey: "splash_text").stringValue ?? ""
        lblSplashText.text = newLabelText
    }
    
    func fetchRemoteConfig() {
        self.remoteConfig.fetch(withExpirationDuration: 0) { (status, error) in
            if status == .success, error == nil {
                self.remoteConfig.activate { status, error in
                    guard error == nil else { return }
                    DispatchQueue.main.async {
                        self.displayNewValue()
                    }
                    Delay.setDelay(3) {
                        if let dest = UIStoryboard(name: "MovieSearch", bundle: nil)
                            .instantiateViewController(withIdentifier: "movieSearchStoryBoardId") as? MovieSearchVC {
                            dest.modalPresentationStyle = .overCurrentContext
                            dest.modalTransitionStyle = .crossDissolve
                            self.navigationController?.pushViewController(dest, animated: false)
                        }
                    }
                }
            }
        }
    }
}
