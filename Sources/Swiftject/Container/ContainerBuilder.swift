//
//  DependencyBuilder.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation

public protocol ContainerComponent {
    func build() -> [Dependency]
}

extension Array: ContainerComponent where Element == Dependency {
    public func build() -> [Dependency] {
        self
    }
}

@resultBuilder
public struct ContainerBuilder {
    
    public static func buildBlock(_ dependencies: ContainerComponent...) -> [Dependency] { dependencies.flatMap({ $0.build() }) }
    
    public static func buildIf(_ dependencies: ContainerComponent?) -> ContainerComponent { dependencies ?? [] }
    
    public static func buildEither(first: ContainerComponent?) -> ContainerComponent { first ?? [] }
    
    public static func buildEither(second: ContainerComponent?) -> ContainerComponent { second ?? [] }
}
