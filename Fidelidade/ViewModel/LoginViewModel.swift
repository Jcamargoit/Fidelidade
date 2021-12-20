//  FrameworkTest
//  Created by Juninho on 26/11/21.

import Foundation

class LoginViewModel {
    
    let loginUseCase = LoginUseCase()
    
    //handleLogin Lidar com alguma coisa
    func handleLogin (loginModel: LoginModel){
        loginUseCase.handleLogin(loginModel: loginModel) { result in
            switch result {
            case .success:
                var s = ""
            case .failure:
                var s = ""
                
                
            }
        }
        
        
    }
    
    
    
}
 
