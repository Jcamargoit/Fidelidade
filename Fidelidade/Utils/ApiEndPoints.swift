//
//  ApiJavaEndPoints.swift
//  Fidelidade
//
//  Created by Raphael de Jesus on 27/12/21.
//

import Foundation


public enum ApiEndPoints {
    case getWallets(userId: Int)
    case getWalletById(userId: Int, walletId: Int)
    case saveWallet
    case updateWallet
    case transferWallet
    
    func baseURL() -> URL? {
        return URL(string: "http://localhost:8001/" + (String(describing: route())))
    }
    
    private func route() -> String {
        switch self {
        case .getWallets(let userId):
            return "Wallet/GetByUserId/" + String(userId)
        case .getWalletById(let userId, let walletId):
            return "Wallet/GetByUserIdAndType/\(userId)/\(walletId)"
        case .saveWallet:
            return "Wallet"
        case .updateWallet:
            return "Wallet"
        case .transferWallet:
            return "Wallet/Transfer"
        }

    }
}
