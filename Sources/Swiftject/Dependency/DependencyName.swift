//
//  InstanceName.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation

public struct DependencyName: Hashable {
    
    let key: String
    
    public init(_ key: String) {
        self.key = key
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    public static func == (lhs: DependencyName, rhs: DependencyName) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

public extension DependencyName {
    static let global: DependencyName = .init("global")
}
