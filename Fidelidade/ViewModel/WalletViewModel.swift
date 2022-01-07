//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit
import Observable


class WalletViewModel {
    
    @MutableObservable private var sMoneyWallet: ResultModel<WalletModel>?
    var moneyWallet: Observable<ResultModel<WalletModel>?>{
        return _sMoneyWallet
    }
    
    @MutableObservable private var sPointsWallet: ResultModel<WalletModel>?
    var pointsWallet: Observable<ResultModel<WalletModel>?>{
        return _sPointsWallet
    }
    
    public var walletUseCase: WalletUseCaseProtocol
    
    init(walletUseCase: WalletUseCaseProtocol = WalletUseCase()){
        self.walletUseCase = walletUseCase
    }
    
    //gravar informações no userDefult (API LOG IN)
    let defaults = UserDefaults.standard
    
    //handleLogin Lidar com alguma coisa
    func fetchWallets (){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
                
            }
            
            let id = self.defaults.integer(forKey: UserDefaultsKeys.userId.rawValue)
            self.walletUseCase.getAllWallets(userId: id) { result in
                switch result {
                case .success(let results):
                    
                    for result in results {
                        if result.walletTypeId == WalletType.Dinheiro.rawValue {
                            self.sMoneyWallet = ResultModel<WalletModel>()
                            self.sMoneyWallet?.saveData(data: result)
                        }else {
                            self.sPointsWallet = ResultModel<WalletModel>()
                            self.sPointsWallet?.saveData(data: result)
                        }
                    }
                    
                    
                    
                case .failure(let error):
                    self.sMoneyWallet = ResultModel<WalletModel>(error: error.description)
                }
            }
        }
    }
}

