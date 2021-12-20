//  FrameworkTest
//  Created by Juninho on 25/11/21.

import Foundation

struct LoginModel: Encodable {
    var cpf: String
    var password: String
    
    init(cpf: String, password: String) {
        self.cpf = cpf
        self.password = password
    }


    //Evitar os casos que retorna com as chaves em letras maiusculas
    enum CodingKeys: String, CodingKey {
            case cpf = "cpf"
            case password = "password"
        }

}




