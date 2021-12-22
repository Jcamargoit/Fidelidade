//  FrameworkTest
//  Created by Juninho on 26/11/21.



import Observable
import UIKit


class MyAccountViewModel {
    
    let defaults = UserDefaults.standard
    
    
    @MutableObservable private var sLogoutIsFinished: Bool?
    var logoutIsFinished: Observable<Bool?>{
        return _sLogoutIsFinished

    }
    
    func handleLogout() {
        
        if let key = defaults.string(forKey: "UserKey"), let cpf = defaults.string(forKey: "UserCpf") {
            defaults.removeObject(forKey: "UserKey")
            defaults.removeObject(forKey: "UserCpf")
            sLogoutIsFinished = true
            
        }
        
        sLogoutIsFinished = false
    }
    
    
    
    
    
    
}



