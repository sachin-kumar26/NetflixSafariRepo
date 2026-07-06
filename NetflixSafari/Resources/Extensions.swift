//
//  Extensions.swift
//  NetflixSafari
//
//  Created by Sachin on 06/07/2026.
//

import Foundation
extension String{
    func capitalizedFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
