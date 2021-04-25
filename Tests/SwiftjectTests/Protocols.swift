//
//  Protocols.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

protocol RESTClient {
    func getModel() -> Model
}

protocol DataProvider {
    func getModel() -> Model
}

protocol Repository {
    func getModel() -> Model
}

protocol MainViewModel {
    func getModel() -> Model
}
