//
//  Spinner.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import NVActivityIndicatorView

open class Spinner {
    
    public static let activityData = ActivityData()
    
    public static func spin() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleRippleMultiple
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.systemYellow
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    public static func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

