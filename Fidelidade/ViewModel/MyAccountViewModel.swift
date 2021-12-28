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
        
        guard let _ = defaults.string(forKey: UserDefaultsKeys.userKey.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userCpf.rawValue) else {
            sLogoutIsFinished = false
            return
        }
        
        defaults.removeObject(forKey: UserDefaultsKeys.userKey.rawValue)
        defaults.removeObject(forKey: UserDefaultsKeys.userCpf.rawValue)
        sLogoutIsFinished = true
    }
    
    
    
    
    
    
}



