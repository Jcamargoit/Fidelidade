//  FrameworkTest
//  Created by Juninho on 25/11/21.

import Foundation

struct LoginModel: Codable {
    let cpf: String
    let password: String
    
    init(cpf: String, password: String) {
        self.cpf = cpf
        self.password = password
    }
    
    func map() -> [String: Any] {
        return ["cpf": self.cpf,
                "password": self.password]
    }
    
    //Evitar os casos que retorna com as chaves em letras maiusculas
    enum CodingKeys: String, CodingKey {
        case cpf = "cpf"
        case password = "password"
    }
    
}
