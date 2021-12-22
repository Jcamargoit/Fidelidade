//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit
import Observable

struct ResultModel<T: Any> {
    var error: String = ""
    var isError: Bool = false
    var data: T?
    
    init (error: String? = nil){
        if let error = error {
            self.error = error
            self.isError = true
       
        }
    }

    mutating func saveData(data: T){
        self.data = data
        self.isError = false
    }
    
}

class LoginViewModel {
    
    @MutableObservable private var sIsLogged: ResultModel<String>?
    let loginUseCase = LoginUseCase()
    var isLogged: Observable<ResultModel<String>?>{
        
        return _sIsLogged
    }
    
    //handleLogin Lidar com alguma coisa
    func handleLogin (loginModel: LoginModel){

        DispatchQueue.main.async { [weak self] in
            self?.loginUseCase.handleLogin(loginModel: loginModel) { result in
                switch result {
                case .success(let key):
                   
                    self?.sIsLogged = ResultModel<String>()
                    self?.sIsLogged?.saveData(data: key)
                case .failure(let error):
                    self?.sIsLogged = ResultModel<String>(error: error.description)
                }
            }
        }
    }
}

