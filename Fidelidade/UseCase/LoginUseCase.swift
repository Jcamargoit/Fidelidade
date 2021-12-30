//
//  LoginUseCase.swift
//  Fidelidade
//
//  Created by Juninho on 20/12/21.
//

import UIKit

/// @mockable
public protocol LoginUseCaseProtocol {
    var url: ApiJavaEndPoints { get set }
    var body: Data? { get set }
    func handleLogin(loginModel: LoginModel, completion: @escaping (Result<String, NetworkError>) -> Void)
}

class LoginUseCase : LoginUseCaseProtocol {
    
    var service = APIService()
    var url = ApiJavaEndPoints.login
    var body: Data?
    
    func handleLogin(loginModel: LoginModel, completion: @escaping (Result<String, NetworkError>) -> Void)  {
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        do {
        body = try JSONSerialization
                .data(withJSONObject: loginModel.map(), options: .prettyPrinted)
        } catch {
            completion(.failure(.decodingError))
        }
        let body = try? JSONEncoder().encode(loginModel)
        let resource = Resource<String>(url: url, httpMethod: .post, body: body)

        service.load(resource: resource) { result in
            completion(result)
            
        }
    }
}
