///
/// @Generated by Mockolo
///


@testable import Fidelidade
import UIKit


public class WalletUseCaseProtocolMock: WalletUseCaseProtocol {
    public init() { }
    public init(body: Data? = nil) {
        self.body = body
    }


    public private(set) var bodySetCallCount = 0
    public var body: Data? = nil { didSet { bodySetCallCount += 1 } }

    public private(set) var getAllWalletsCallCount = 0
    public var getAllWalletsHandler: ((Int, @escaping (Result<[WalletModel], NetworkError>) -> Void) -> ())?
    public func getAllWallets(userId: Int, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void)  {
        getAllWalletsCallCount += 1
        if let getAllWalletsHandler = getAllWalletsHandler {
            getAllWalletsHandler(userId, completion)
        }
        
    }

    public private(set) var getWalletsByIdCallCount = 0
    public var getWalletsByIdHandler: ((Int, WalletType, @escaping (Result<[WalletModel], NetworkError>) -> Void) -> ())?
    public func getWalletsById(userId: Int, walletType: WalletType, completion: @escaping (Result<[WalletModel], NetworkError>) -> Void)  {
        getWalletsByIdCallCount += 1
        if let getWalletsByIdHandler = getWalletsByIdHandler {
            getWalletsByIdHandler(userId, walletType, completion)
        }
        
    }

    public private(set) var saveWalletCallCount = 0
    public var saveWalletHandler: ((WalletModel, @escaping (Result<WalletModel, NetworkError>) -> Void) -> ())?
    public func saveWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void)  {
        saveWalletCallCount += 1
        if let saveWalletHandler = saveWalletHandler {
            saveWalletHandler(wallet, completion)
        }
        
    }

    public private(set) var upDateWalletCallCount = 0
    public var upDateWalletHandler: ((WalletModel, @escaping (Result<WalletModel, NetworkError>) -> Void) -> ())?
    public func upDateWallet(wallet: WalletModel, completion: @escaping (Result<WalletModel, NetworkError>) -> Void)  {
        upDateWalletCallCount += 1
        if let upDateWalletHandler = upDateWalletHandler {
            upDateWalletHandler(wallet, completion)
        }
        
    }
}
