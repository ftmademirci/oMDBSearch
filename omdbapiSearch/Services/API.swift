//
//  API.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

typealias SearchCallback = (_ data: SearchModel?, _ error: String?) -> Void
typealias MovieCallback = (_ data: MovieModel?, _ error: String?) -> Void

protocol ServicesProvider {
    func search(query: String, callback: @escaping SearchCallback)
    func getDetail(imdbID: String, callback: @escaping MovieCallback)
}

protocol ApiProvider: ServicesProvider { }

class API: ApiProvider {
    
    func search(query: String, callback: @escaping SearchCallback) {
        let url = "\(Constant.apiUrl)?s=\(query)&apikey=\(Constant.apiKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        Spinner.spin()
        
        Alamofire.request(request).responseJSON { response in
            print("----", response)
            Spinner.stop()
            switch response.result {
            case .success(let value):
                let data = JSON(value)
                guard let parsedData = Mapper<SearchModel>().map(JSON: data.rawValue as! [String : Any]) else {
                    print("Mapping Error in search")
                    return
                }
                callback(parsedData, nil)
                
            case .failure(_):
                let errorCode = response.result.error!._code
                let message = ErrorUtility.errorMessageFor(errorcode: errorCode)
                callback(nil, message)
            }
        }
    }
    
    func getDetail(imdbID: String, callback: @escaping MovieCallback) {
        let url = "\(Constant.apiUrl)?i=\(imdbID)&apikey=\(Constant.apiKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        Spinner.spin()
        
        Alamofire.request(request).responseJSON { response in
            Spinner.stop()
            switch response.result {
            case .success(let value):
                let data = JSON(value)
                guard let parsedData = Mapper<MovieModel>().map(JSON: data.rawValue as! [String : Any]) else {
                    print("Mapping Error in detail")
                    return
                }
                callback(parsedData, nil)
                
            case .failure(_):
                let errorCode = response.result.error!._code
                let message = ErrorUtility.errorMessageFor(errorcode: errorCode)
                callback(nil, message)
            }
        }
    }
}


