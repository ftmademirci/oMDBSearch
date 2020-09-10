//
//  MovieModel.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieModel : NSObject, NSCoding, Mappable {
    
    var Actors: String?
    var Awards: String?
    var Director: String?
    var Genre: String?
    var imdbID: String?
    var imdbRating: String?
    var Plot: String?
    var Poster: String?
    var Runtime: String?
    var Title: String?
    var Year: String?
    
    
    class func newInstance(map: Map) -> Mappable? {
        return MovieModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        Actors <- map["Actors"]
        Awards <- map["Awards"]
        Director <- map["Director"]
        Genre <- map["Genre"]
        imdbID <- map["imdbID"]
        imdbRating <- map["imdbRating"]
        Plot <- map["Plot"]
        Poster <- map["Poster"]
        Runtime <- map["Runtime"]
        Title <- map["Title"]
        Year <- map["Year"]
        
    }
    
    @objc required init(coder aDecoder: NSCoder)
    {
        Actors = aDecoder.decodeObject(forKey: "Actors") as? String
        Awards = aDecoder.decodeObject(forKey: "Awards") as? String
        Director = aDecoder.decodeObject(forKey: "Director") as? String
        Genre = aDecoder.decodeObject(forKey: "Genre") as? String
        imdbID = aDecoder.decodeObject(forKey: "imdbID") as? String
        imdbRating = aDecoder.decodeObject(forKey: "imdbRating") as? String
        Plot = aDecoder.decodeObject(forKey: "Plot") as? String
        Poster = aDecoder.decodeObject(forKey: "Poster") as? String
        Runtime = aDecoder.decodeObject(forKey: "Runtime") as? String
        Title = aDecoder.decodeObject(forKey: "Title") as? String
        Year = aDecoder.decodeObject(forKey: "Year") as? String
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        if Actors != nil{
            aCoder.encode(Actors, forKey: "Actors")
        }
        if Awards != nil{
            aCoder.encode(Awards, forKey: "Awards")
        }
        if Director != nil{
            aCoder.encode(Director, forKey: "Director")
        }
        if Genre != nil{
            aCoder.encode(Genre, forKey: "Genre")
        }
        if imdbID != nil{
            aCoder.encode(imdbID, forKey: "imdbID")
        }
        if imdbRating != nil{
            aCoder.encode(imdbRating, forKey: "imdbRating")
        }
        if Plot != nil{
            aCoder.encode(Plot, forKey: "Plot")
        }
        if Poster != nil{
            aCoder.encode(Poster, forKey: "Poster")
        }
        if Runtime != nil{
            aCoder.encode(Runtime, forKey: "Runtime")
        }
        if Title != nil{
            aCoder.encode(Title, forKey: "Title")
        }
        if Year != nil{
            aCoder.encode(Year, forKey: "Year")
        }
    }
    
}

