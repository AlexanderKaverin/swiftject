//
//  DependencyContainer.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 18.04.2021.
//

import Foundation

public class Container {
    
    internal static var instance = Container()
    
    private var objectGraph: [DependencyIdentifier: Dependency] = [:]
    
    internal init() { }
    
    deinit {
        objectGraph.removeAll()
    }
}

internal extension Container {
    func register(_ provider: Dependency) {
        let identifier = provider.dependencyIdentifier
        
        guard objectGraph[identifier] == nil else {
            fatalError("Dependency '\(identifier)' already registered in container. Remove redundant registration calls.")
        }
        
        objectGraph[identifier] = provider
    }
    
    func resolve<T>(_ name: DependencyName = .global) -> T {
        let dependencyIdentifier = DependencyIdentifier(name: name, type: T.self)
        
        guard var dependency = objectGraph[dependencyIdentifier] else {
            fatalError("Unable to resolve unregistered dependency '\(dependencyIdentifier)'")
        }
        
        guard let instance = dependency.instance as? T, dependency.scope == .singleton else {
            dependency.instance = dependency.createInstance(self)
            objectGraph[dependencyIdentifier] = dependency
            return dependency.instance as! T
        }
        
        return instance
    }
}
