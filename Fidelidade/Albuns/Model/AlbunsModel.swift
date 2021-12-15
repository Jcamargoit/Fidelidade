////  FrameworkTest
////  Created by Juninho on 25/11/21.

import Foundation

struct AlbunsModel: Codable {
    let title: String
}

extension AlbunsModel {
    // Resgatar Api Json com forma de OBJ
    static var Get:  Resource<[AlbunsModel]> = {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else{
            fatalError("URL is incorrect!")
        }
        return Resource<[AlbunsModel]>(url: url)
    }()
}
