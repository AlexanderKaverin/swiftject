//
//  Module.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 20.04.2021.
//

import Foundation

@_functionBuilder
public struct ModuleBuilder {
        
    public static func buildBlock(_ dependencies: ContainerComponent...) -> Module {
        Module(dependencies.flatMap({ $0.build() }))
    }
}

public class Module: ContainerComponent {
    
    private let dependencies: [Dependency]
    
    init(_ dependencies: [Dependency]) {
        self.dependencies = dependencies
    }
    
    public func build() -> [Dependency] {
        dependencies
    }
}
