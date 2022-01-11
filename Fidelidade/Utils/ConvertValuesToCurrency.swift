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
        formatter.locale = Locale(identifier: "pt-BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let valueReal = formatter.string(from: value as NSNumber) {
            return valueReal
        }
        return ""
    }
}

