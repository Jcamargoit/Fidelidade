//
//  ApiJavaEndPoints.swift
//  Fidelidade
//
//  Created by Raphael de Jesus on 27/12/21.
//

import Foundation


enum ApiJavaEndPoints {
    
    case login
    
    func baseURL() -> URL? {
        return URL(string: "http://localhost:8081/\(String(describing: route()))")
    }
    
    private func route() -> String {
        switch self {
        case .login:
            return "login"
        }
    }
}
