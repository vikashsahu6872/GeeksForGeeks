//
//  APIService.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct APIRequest<T:Decodable>{
    let url : String
    var httpMethod: HttpMethod = .get
    var body : Data? = nil
    var header : [String:String]? = nil
    
    init(url:String) {
        self.url = url
    }
}


class APIService{
    
    static var shared = APIService()
    private init(){}
    private let cache = NSCache<NSString,UIImage>()
    
    func load<T>(request:APIRequest<T>,completion: @escaping (Result<T,APIError>)-> Void){
        guard  let url = URL(string: request.url) else {
            completion(.failure(.badURL))
            return
        }
        var apiRequest = URLRequest(url: url)
        apiRequest.httpBody = request.body
        apiRequest.httpMethod = request.httpMethod.rawValue
        request.header?.forEach({key,value in
            apiRequest.setValue(key, forHTTPHeaderField:value)
        })
        
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error as? URLError{
                    completion(.failure(APIError.url(error)))
                }else if let response = response as? HTTPURLResponse, !(200...209).contains(response.statusCode){
                    completion(.failure(APIError.badResponse(statusCode: response.statusCode)))
                    
                }else if let data = data{
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(APIError.parsing(error as? DecodingError)))
                    }
                }else{
                    completion(.failure(.unknown))
                }
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString:String,completion: @escaping (UIImage?)-> Void){
        guard  let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with:url){data,response,error in
            guard let data = data ,let image = UIImage(data: data) else{
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey:cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}
