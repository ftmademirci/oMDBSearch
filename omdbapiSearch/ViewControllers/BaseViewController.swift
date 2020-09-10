//
//  BaseViewController.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addedNavBar()
        
    }
    
    func addedNavBar() {
        
        let navBar = self.navigationController?.navigationBar
        navBar?.barStyle = .black
        navBar?.isTranslucent = false
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func fetchRemoteConfig() {
        RemoteConfig.remoteConfig().configSettings = RemoteConfigSettings()
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) {
            (status, error) in
            
            guard error == nil else {
                print("Error")
                return
            }
            
            RemoteConfig.remoteConfig().activate(completion: .none)
        }
    }
    
    func openMainScreen() {
        let mainViewController = UIStoryboard.mainViewScreen.mainViewController
        let nav = UINavigationController(rootViewController: mainViewController)
        nav.hero.isEnabled = true
        nav.heroNavigationAnimationType = .fade
        nav.modalPresentationStyle = .fullScreen
        self.show(nav, sender: nil)
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func openDetailScreen(movie: MovieModel) {
        let detailViewController = UIStoryboard.detailScreen.detailViewController
        let viewModel = DetailViewModel(dependencies: DetailViewModel.Dependencies(api: API()))
        viewModel.movie = movie
        detailViewController.viewModel = viewModel
        self.show(detailViewController, sender: nil)
    }
}

