//  APIService.swift
//  Created by Juninho on 25/11/21.

import Foundation

public enum NetworkError: Error {
    case decodingError // JASON MODEL
    case domainError //Erro 500
    case loginError //
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .decodingError, .domainError:
            return "Houve um erro ao conectar ao servidor"
        case .loginError:
            return "Houve um erro ao efetuar o log in"
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum ReturnType: String {
    case simple
    case object
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
    
    func load<T>(resource: Resource<T>, returnType: ReturnType = .simple, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")      // the expected response is also JSON
       
        //Request
        URLSession.shared.dataTask(with: request) { data, response, error in
          
            var statusCode = 0
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            //Get StatusCode da resposta da conexão
            if let httpResponse = response as? HTTPURLResponse {
                print("status response: \(httpResponse.statusCode)")
                statusCode = httpResponse.statusCode
            }
            if returnType == .simple {
                if let dataString = String(data: data, encoding: .utf8), statusCode == 200{
                        completion(.success(dataString as! T))
                }else {
                    completion(.failure(.domainError))
                }
            }else if  returnType == .object {
                let result = try? JSONDecoder().decode(T.self, from: data)
                if let result = result {
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
               }else {
                   completion(.failure(.decodingError))
               }
            }
        else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
