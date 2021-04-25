//
//  Inject.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 17.04.2021.
//

import Foundation

@propertyWrapper public struct Inject<T> {
    
    typealias LazyInjection = () -> T
    
    private var dependency: T? = nil
    private var lazyInjection: LazyInjection? = nil
    
    public var wrappedValue: T {
        mutating get {
            guard let dependency = dependency ?? lazyInjection?() else {
                fatalError("Unable to inject unresolved dependency of type '\(String(describing: T.self))'")
            }
            
            return dependency
        }
    }
    
    public init(_ dependencyName: DependencyName = .global, lazy: Bool = false) {
        if lazy {
            self.lazyInjection = { Container.instance.resolve(dependencyName) }
        } else {
            let resolvedDependency: T = Container.instance.resolve(dependencyName)
            self.dependency = resolvedDependency
        }
    }
}
