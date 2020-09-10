//
//  SplashViewController.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: BaseViewController {
    
    @IBOutlet var campany_title: UILabel!
    
    var timer: Timer!
    
     func updateViewWithRCValues() {
         let labelText = RemoteConfig.remoteConfig().configValue(forKey: "campany_title").stringValue ?? ""
         campany_title.text = labelText
     }
    
     func setupRemoteConfigDefaults() {
         let defaultValues = [
             "campany_title" : "oMDB" as NSObject
         ]
         RemoteConfig.remoteConfig().setDefaults(defaultValues)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupRemoteConfigDefaults()
        updateViewWithRCValues()
        fetchRemoteConfig()

        self.networkControl()
        
    }
    func networkControl() {
        if self.isConnectedToInternet() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
                self.openMainScreen()
                self.timer.invalidate()
            })
        } else {
            self.alertShow()
        }
    }
    func alertShow() {
        let alert = UIAlertController(title: "No Internet connection!", message: "Please Check Your Connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (alert: UIAlertAction!) in
            self.networkControl()
        }))
        self.present(alert, animated: true)
    }
    
}
