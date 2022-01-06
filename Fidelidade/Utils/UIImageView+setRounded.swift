//
//  Extension.swift
//  Fidelidade
//
//  Created by Juninho on 04/01/22.
//

import Foundation
import UIKit



//Imagem Redonda
extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}



