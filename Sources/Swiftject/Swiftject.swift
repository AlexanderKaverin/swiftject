//
//  Swiftject.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

public extension Container {

    static func add(@ContainerBuilder _ provider: () -> Dependency) {
        instance.register(provider())
    }
    
    static func add(@ContainerBuilder _ providers: () -> [Dependency]) {
        providers().forEach({ instance.register($0) })
    }
    
    func get<T>(_ name: DependencyName = .global) -> T {
        return resolve(name)
    }
}
