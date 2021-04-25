//
//  DependencyIdentifer.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation

internal struct DependencyIdentifier: Hashable, CustomStringConvertible {
    
    let name: DependencyName
    let type: Any.Type
    
    var description: String { "\(name.key)_\(String(describing: type))" }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(String(describing: type))
    }
    
    static func == (lhs: DependencyIdentifier, rhs: DependencyIdentifier) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
