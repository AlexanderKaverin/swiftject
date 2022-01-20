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
@propertyWrapper public struct InjectObserved<T>: DynamicProperty where T: ObservableObject {
    
    @ObservedObject private var dependency: T
    
    public var wrappedValue: T {
        get { return dependency }
        mutating set { dependency = newValue }
    }
    
    public var projectedValue: ObservedObject<T>.Wrapper {
        return self.$dependency
    }
    
    public init() {
        self.dependency = Container.instance.resolve()
    }
}
#endif
