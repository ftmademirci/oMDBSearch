//
//  MainViewModel.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation

class MainViewModel  {
    
    var searchData: SearchModel?
    var detailData: MovieModel?
    
    struct Dependencies {
        let api: API
    }
    
    public let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // search
    func search(searchText: String, success: @escaping() -> Void,
                failure: @escaping (String?) -> Void) {
        dependencies.api.search(query: searchText) { (response, error) in
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.searchData = response
                success()
            }
        }
    }
    
    public func numberOfItems() -> Int {
        return searchData?.Search?.count ?? 0
    }
}




