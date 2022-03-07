//
//  SplashVC.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 6.03.2022.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkMonitor.shared.isConnected {
            // Remoteconfigden alınacak string 3 saniye ekranda gösterilecek
            
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
    func fetchRemoteConfig() {
        //
    }
}
