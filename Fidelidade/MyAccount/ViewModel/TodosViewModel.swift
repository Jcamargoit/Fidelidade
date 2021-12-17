//  FrameworkTest
//  Created by Juninho on 26/11/21.

import Foundation

class TodosViewModel {
    
    var todosViewModel: [TodosModel]
    init() {
        self.todosViewModel = [TodosModel]()
    }
}

extension TodosViewModel {
    func todosViewModel(at index:Int) -> TodosModel   {
        return self.todosViewModel[index]
    }
}

struct AllModel {
    let all: TodosModel
}

extension AllModel{
    var title: String{
        return self.all.title
    }
    var completed: Bool{
        return self.all.completed
    }
}
