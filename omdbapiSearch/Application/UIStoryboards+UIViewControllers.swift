//
//  UIStoryboards+UIViewControllers.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var detailScreen: UIStoryboard {
        return UIStoryboard(name: "Detail", bundle: nil)
    }
    
    static var mainViewScreen: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    
    var detailViewController: DetailViewController {
        guard let vc = UIStoryboard.detailScreen.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("DetailViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var mainViewController: MainViewController {
        guard let vc = UIStoryboard.mainViewScreen.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("MainViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}

