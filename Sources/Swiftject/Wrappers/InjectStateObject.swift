//
//  InjectObserved.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation
import SwiftUI


@available(iOS 14, *)
@propertyWrapper public struct InjectStateObject<T>: DynamicProperty where T: ObservableObject {
 
    private var dependency: T
    
    public var wrappedValue: T {
        get { return dependency }
        mutating set { dependency = newValue }
    }
    
    public var projectedValue: ObservedObject<T>.Wrapper {
        return StateObject(wrappedValue: dependency).projectedValue
    }
    
    public init() {
        self.dependency = Container.instance.resolve()
    }
}
