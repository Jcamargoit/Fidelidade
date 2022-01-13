//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit
import Observable


struct ResultModel<T: Any> {
    var error: String = ""
    var isError: Bool = false
    var data: T?
    
    init (data: T? = nil, error: String? = nil){
        if let error = error {
            self.error = error
            self.isError = true
        } else {
            self.data = data
            self.isError = false
        }
    }
}


class LoginViewModel {
    
    @MutableObservable private var sIsLogged: ResultModel<String>?
    var isLogged: Observable<ResultModel<String>?>{
        return _sIsLogged
    }
    
    public var loginUseCase: LoginUseCaseProtocol?
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()){
        self.loginUseCase = loginUseCase
    }
    
    //gravar informações no userDefult (API LOG IN)
    let defaults = UserDefaults.standard
    
    //handleLogin Lidar com alguma coisa
    func  handleLogin (loginModel: LoginModel){
        if let key = defaults.string(forKey: UserDefaultsKeys.userKey.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userCpf.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userId.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userImageProfile.rawValue) {
            sIsLogged = ResultModel<String>(data: key)
        } else {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.loginUseCase?.handleLogin(loginModel: loginModel) { [weak self] result in
                switch result {
                case .success(let key):
                    //gravar informações no userDefult (API LOG IN)
                    self?.defaults.set(key, forKey: UserDefaultsKeys.userKey.rawValue)
                    self?.defaults.set(loginModel.cpf, forKey: UserDefaultsKeys.userCpf.rawValue)
                    self?.defaults.set(1, forKey: UserDefaultsKeys.userId.rawValue)
                    
                    self?.sIsLogged = ResultModel<String>(data: key)
                case .failure(let error):
                    self?.sIsLogged = ResultModel<String>(error: error.description)
                }
            }
        }
        }
    }
}

