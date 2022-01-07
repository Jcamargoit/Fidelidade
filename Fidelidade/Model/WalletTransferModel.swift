//  FrameworkTest
//  Created by Juninho on 25/11/21.

import Foundation

public struct WalletTransferModel: Codable {
    let walletOriginId: Int
    let walletTargetId: Int
    let quantity: Int
    
    init(walletOriginId: Int, walletTargetId: Int, quantity: Int) {
        self.walletOriginId = walletOriginId
        self.walletTargetId = walletTargetId
        self.quantity = quantity
    }
    
    func map() -> [String: Any] {
        return ["walletOriginId": self.walletOriginId,
                "walletTargetId": self.walletTargetId,
                "quantity": self.quantity,
        ]
    }
    
    //Evitar os casos que retorna com as chaves em letras maiusculas
    enum CodingKeys: String, CodingKey {
        case walletOriginId = "walletOriginId"
        case walletTargetId = "walletTargetId"
        case quantity = "quantity"
    }
    
}
