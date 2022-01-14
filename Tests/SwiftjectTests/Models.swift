//
//  Models.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

import Foundation

struct Model {
    let string: String
    let source: ModelSource
}

class ViewModel: NSObject, ObservableObject {
    var test: String = "ViewModel.instance"
}
