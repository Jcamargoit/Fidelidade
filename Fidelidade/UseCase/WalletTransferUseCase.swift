//  LoginUseCase.swift
//  Fidelidade
//
//  Created by Juninho on 20/12/21.
//
import UIKit

/// @mockable
public protocol WalletTransferUseCaseProtocol {
    func walletTransfer(walletTransfer: WalletTransferModel, completion: @escaping (Result<WalletTransferModel, NetworkError>) -> Void)
}

class WalletTransferUseCase : WalletTransferUseCaseProtocol {
    
    var service = APIService()
    var body: Data?
    
    //POST
    func walletTransfer(walletTransfer: WalletTransferModel, completion: @escaping (Result<WalletTransferModel, NetworkError>) -> Void) {
 
        let url = ApiEndPoints.transferWallet
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        do {
            body = try JSONSerialization
                .data(withJSONObject: walletTransfer.map(), options: .prettyPrinted)
        } catch {
            completion(.failure(.decodingError))
        }
        let resource = Resource<WalletTransferModel>(url: url, httpMethod: .post, body: body)
        
        service.load(resource: resource, returnType: .object) { result in
            completion(result)
        }
        
    }
}
