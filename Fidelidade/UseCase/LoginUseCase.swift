//
//  LoginUseCase.swift
//  Fidelidade
//
//  Created by Juninho on 20/12/21.
//

import Foundation


class LoginUseCase {
    
    var service = APIService()
    var url = URL(string: "http://localhost:8081/login")
    
    func handleLogin(loginModel: LoginModel, completion: @escaping (Result<String, NetworkError>) -> Void)  {
        guard let url = url else {
            fatalError("URL is incorrect!")
        }
        
        let jsonEncoder = JSONEncoder()
        let body = try? jsonEncoder.encode(loginModel)
        
        let resource = Resource<String>(url: url, httpMethod: .post, body: body)
        
        service.load(resource: resource) { result in
            completion(result)
            
        }
    }
}
