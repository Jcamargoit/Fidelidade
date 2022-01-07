//  FrameworkTest
//  Created by Juninho on 25/11/21.

import Foundation

public struct WalletModel: Codable {
    let id: Int?
    let drugstoreId: Int
    let userId: Int
    let walletTypeId: Int
    let amount: Int
    let cpf: String?
    let name: String?
    

    init(id: Int? = nil, drugstoreId: Int, userId: Int, walletTypeId: Int, amount: Int, cpf: String? = nil, name: String? = nil) {
        self.id = id
        self.drugstoreId = drugstoreId
        self.userId = userId
        self.walletTypeId = walletTypeId
        self.amount = amount
        self.cpf = cpf
        self.name = name
    }
    
    func map() -> [String: Any] {
        return ["id": self.id,
                "drugstoreId": self.drugstoreId,
                "userId": self.userId,
                "walletTypeId": self.walletTypeId,
                "amount": self.amount,
                "cpf": self.cpf,
                "name": self.name
        ]
    }
    
    //Evitar os casos que retorna com as chaves em letras maiusculas
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case drugstoreId = "drugstoreId"
        case userId = "userId"
        case walletTypeId = "walletTypeId"
        case amount = "amount"
        case cpf = "cpf"
        case name = "name"
    }
    
}
