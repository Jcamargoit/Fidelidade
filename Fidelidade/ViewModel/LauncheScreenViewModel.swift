//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit
import Observable

class LauncheScreenViewModel {
    
    
    @MutableObservable private var sIsLogged: Bool?
    var isLogged: Observable<Bool?>{
        return _sIsLogged
    }
    
    let defaults = UserDefaults.standard
    
    func validateUserIsLogged (){

        guard let key = defaults.string(forKey: "UserKey") else{
            sIsLogged = false
            return
        }
        sIsLogged = true
        
    }
    
   
}
