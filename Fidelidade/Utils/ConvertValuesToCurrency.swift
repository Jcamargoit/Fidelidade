//
//  ConvertValuesToCurrency.swift
//  Fidelidade
//
//  Created by Juninho on 11/01/22.
//

import Foundation
import UIKit

class ConvertValuesToCurrency{
    
    func convertValuesToCurrency(value: Double) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        if let valueReal = formatter.string(from: value as NSNumber) {
            return valueReal
        }
        return ""
    }
}

