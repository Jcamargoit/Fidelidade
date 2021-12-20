//  APIService.swift
//  Created by Juninho on 25/11/21.

import Foundation

enum NetworkError: Error {
    case decodingError // JASON MODEL
    case domainError //ErrO 500
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
  
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod
    var body: Data?
    

    init(url: URL, httpMethod: HttpMethod, body: Data? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = body
    }
}

//URLSession

class APIService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
