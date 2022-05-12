//
//  APIError.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import Foundation

enum APIError:Error,CustomStringConvertible{
    case badURL
    case badResponse(statusCode:Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizeDescription:String{
        // user feedback
        switch self{
        case .badURL,.parsing,.unknown:
            return "Sorry, somethihg went wrong."
        case .badResponse(_):
            return "sorry, the connection to our server failed "
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
    
    var description : String {
        // info for debugging
        switch self {
        case .unknown:
            return "unknown error"
        case .badURL:
            return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
    
    
}

