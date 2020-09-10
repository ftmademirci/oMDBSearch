//
//  DetailViewModel.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation

class DetailViewModel  {
    
    var movie: MovieModel?
    
    struct Dependencies {
        let api: API
    }
    
    public let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getDetail(imdbID: String, success: @escaping() -> Void,
                failure: @escaping (String?) -> Void) {
        dependencies.api.getDetail(imdbID: imdbID) { (response, error) in
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.movie = response
                success()
            }
        }
    }
}
