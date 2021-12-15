////  FrameworkTest
////  Created by Juninho on 26/11/21.

import Foundation

class AlbunsViewModel {
    
    var albunsViewModel: [AlbunsModel]
    init() {
        self.albunsViewModel = [AlbunsModel]()
    }
}

extension AlbunsViewModel {
    func albunsViewModel(at index:Int) -> AlbunsModel   {
        return self.albunsViewModel[index]
    }
}

struct AlbModel {
    let alb: AlbunsModel
}

extension AlbModel{
    var title: String{
        return self.alb.title
    }
    
}
