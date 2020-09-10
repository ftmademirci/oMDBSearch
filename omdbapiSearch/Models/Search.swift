//
//  Search.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchModel : NSObject, NSCoding, Mappable{
    
    var Search : [MovieModel]?
    var totalResults : String?
    var Response : String?

    class func newInstance(map: Map) -> Mappable?{
        return SearchModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        Search <- map["Search"]
        totalResults <- map["totalResults"]
        Response <- map["Response"]
        
    }
    
    @objc required init(coder aDecoder: NSCoder)
    {
        Search = aDecoder.decodeObject(forKey: "Search") as? [MovieModel]
        totalResults = aDecoder.decodeObject(forKey: "totalResults") as? String
        Response = aDecoder.decodeObject(forKey: "Response") as? String
        
    }
    
    
    @objc func encode(with aCoder: NSCoder)
    {
        if Search != nil{
            aCoder.encode(Search, forKey: "Search")
        }
        if totalResults != nil{
            aCoder.encode(totalResults, forKey: "totalResults")
        }
        if Response != nil{
            aCoder.encode(Response, forKey: "Response")
        }
        
    }
    
}



