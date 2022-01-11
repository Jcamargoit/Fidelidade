import UIKit
import Observable





class WalletTransferViewModel {
    
    

    
    //Enviar para api
    @MutableObservable private var sTransferWallet: ResultModel<WalletTransferModel>?
    var transferWallet: Observable<ResultModel<WalletTransferModel>?>{
        return _sTransferWallet
    }

    public var transferUseCase: WalletTransferUseCaseProtocol
    
    init(transferUseCase: WalletTransferUseCaseProtocol = WalletTransferUseCase()){
        self.transferUseCase = transferUseCase
    }
    
    //gravar informações no userDefult (API LOG IN)
    let defaults = UserDefaults.standard
    
    //handle Lidar com alguma coisa
    func transferWallets (walletTransfer: WalletTransferModel){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            self.transferUseCase.walletTransfer(walletTransfer: walletTransfer) {[weak self] result in
                switch result {
                case .success(let result):

                    print("resultado chamada  \(result)")
                    self?.sTransferWallet = ResultModel<WalletTransferModel>()
                    self?.sTransferWallet?.saveData(data: result)
                   
                case .failure(let error):
                    self?.sTransferWallet = ResultModel<WalletTransferModel>(error: error.description)
                }
            }
        }
    }
}
