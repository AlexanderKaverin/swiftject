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
 
    private var dependency: StateObject<T>
    
    public var wrappedValue: T {
        get { return dependency.wrappedValue }
        mutating set { dependency = StateObject(wrappedValue: newValue) }
    }
    
    public var projectedValue: ObservedObject<T>.Wrapper {
        return dependency.projectedValue
    }
    
    public init() {
        self.dependency = Container.instance.resolve()
    }
}
