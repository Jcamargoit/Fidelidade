//
//  LoginUseCase.swift
//  Fidelidade
//
//  Created by Juninho on 20/12/21.
//

import UIKit

/// @mockable
public protocol WalletUseCaseProtocol {
    var body: Data? { get set }
    func getAllWallets(userId: Int, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void)
    func getWalletsById(userId: Int, walletType: WalletType, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void)
    func saveWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void)
    func upDateWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void)
}

class WalletUseCase : WalletUseCaseProtocol {
    
    var service = APIService()
    var body: Data?
    //GET
    func getAllWallets(userId: Int, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void) {
        //Todas carteiras
        let url = ApiEndPoints.getWallets(userId: userId)
        
        //validar url
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        let resource = Resource<[WalletModel]>(url: url, httpMethod: .get)
        
        service.load(resource: resource, returnType: .object) { result in
            completion(result)
        }
    }
    //GET
    func getWalletsById(userId: Int, walletType: WalletType, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void) {
        //Carteiras tipo pontos
        let url = ApiEndPoints.getWalletById(userId: userId, walletId: walletType.rawValue)
        
        //validar url
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        let resource = Resource<[WalletModel]>(url: url, httpMethod: .get)
        
        service.load(resource: resource, returnType: .object) { result in
            completion(result)
        }
    }
    //POST
    func saveWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void) {
        
        
        let url = ApiEndPoints.saveWallet
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        do {
            body = try JSONSerialization
                .data(withJSONObject: wallet.map(), options: .prettyPrinted)
        } catch {
            completion(.failure(.decodingError))
        }
        
        let resource = Resource<WalletModel>(url: url, httpMethod: .post, body: body)
        
        service.load(resource: resource, returnType: .object) { result in
            completion(result)
        }
        
    }
    //PUT
    func upDateWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void) {
        let url = ApiEndPoints.updateWallet
        guard let url = url.baseURL() else {
            fatalError("URL is incorrect!")
        }
        do {
            body = try JSONSerialization
                .data(withJSONObject: wallet.map(), options: .prettyPrinted)
        } catch {
            completion(.failure(.decodingError))
        }
        
        let resource = Resource<WalletModel>(url: url, httpMethod: .put, body: body)
        
        service.load(resource: resource, returnType: .object) { result in
            completion(result)
        }
        
    }
    
}
