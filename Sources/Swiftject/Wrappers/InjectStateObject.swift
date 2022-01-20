//
//  InjectObserved.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 19.04.2021.
//

import Foundation
import SwiftUI

#if canImport(SwiftUI)
@available(iOS 14, *)
@propertyWrapper public struct InjectStateObject<T>: DynamicProperty where T: ObservableObject {
    
    private var dependency: T
    private var stateObject: StateObject<T>
    
    public var wrappedValue: T {
        get { return stateObject.wrappedValue }
    }
    
    public var projectedValue: ObservedObject<T>.Wrapper {
        return stateObject.projectedValue
    }
    
    public init() {
        let dependencyObject: T = Container.instance.resolve()
        self.dependency = dependencyObject
        self.stateObject = StateObject(wrappedValue: dependencyObject)
    }
}
#endif
