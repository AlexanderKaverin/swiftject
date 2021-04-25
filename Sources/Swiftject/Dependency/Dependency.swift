//
//  Dependency.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation

public struct Dependency {
    
    public enum Mode {
        case singleton
        case perInstance
    }
    
    public class Provide<T>: ContainerComponent {
                
        private var mode: Dependency.Mode?
        private var name: DependencyName?
        private var resolver: (Container) -> T
        
        public init(_ resolver: @escaping (Container) -> T) {
            self.resolver = resolver
        }
        
        public convenience init(_ resolver: @escaping () -> T) {
            self.init { _ in resolver() }
        }
        
        func named(_ name: DependencyName) -> Provide {
            self.name = name
            return self
        }
        
        func mode(_ mode: Dependency.Mode) -> Provide {
            self.mode = mode
            return self
        }
        
        public func build() -> [Dependency] {
            return [Dependency(mode ?? .singleton, named: name ?? .global, resolver)]
        }
    }
    
    internal let dependencyIdentifier: DependencyIdentifier
    internal var instance: Any?
    internal var scope: Mode
    internal var resolve: (Container) -> Any
    internal var name: DependencyName
    
    private init<T>(_ scope: Mode, named dependencyName: DependencyName, _ resolve: @escaping (Container) -> T) {
        self.dependencyIdentifier = .init(name: dependencyName, type: T.self)
        self.scope = scope
        self.resolve = resolve
        self.name = dependencyName
    }
    
    private init<T>(_ scope: Mode, named dependencyName: DependencyName, _ resolve: @escaping () -> T) {
        self.init(scope, named: dependencyName, { container in
            return resolve()
        })
    }
    
    internal func createInstance(_ container: Container) -> Any {
        guard let instance = instance else {
            return resolve(container)
        }
        
        switch scope {
        case .singleton: return instance
        case .perInstance: return resolve(container)
        }
    }
}
