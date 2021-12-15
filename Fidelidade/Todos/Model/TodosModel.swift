//  FrameworkTest
//  Created by Juninho on 25/11/21.

import Foundation

struct TodosModel: Codable {
    let title: String
    let completed: Bool
}

extension TodosModel {
    // Resgatar Api Json com forma de OBJ
    static var Get:  Resource<[TodosModel]> = {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else{
            fatalError("URL is incorrect!")
        }
        return Resource<[TodosModel]>(url: url)
    }()
}
