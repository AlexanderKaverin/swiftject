//
//  File.swift
//  
//
//  Created by Alexander Kaverin on 25.04.2021.
//

import Foundation
import Swiftject

enum ModelSource {
    case remote
    case local
    case mock
}

class ConcreteRESTCLient: RESTClient {
    func getModel() -> Model {
        Model(string: "remote model", source: .remote)
    }
}

class LocalDataProvider: DataProvider {
    func getModel() -> Model {
        Model(string: "local model", source: .local)
    }
}

class RemoteDataProvider: DataProvider {
    
    private let client: RESTClient
    
    // constructor injection
    init(client: RESTClient) {
        self.client = client
    }
    
    func getModel() -> Model {
        client.getModel()
    }
}

class ConcreteRepository: Repository {
    
    // field injection (compnents of the Data Layer should use constructor injection)
    @Inject(.localDataProvider) private var local: DataProvider
    @Inject(.remoteDataProvider) private var remote: DataProvider
    @Inject(.networkAvailabilityFlag) private var connectivityAvailable: Bool
    
    func getModel() -> Model {
        connectivityAvailable
            ? remote.getModel()
            : local.getModel()
    }
}

class MainViewModelImpl: MainViewModel {
    
    // field injection
    @Inject private var repository: Repository
    
    func getModel() -> Model {
        repository.getModel()
    }
}

class MockMainViewModel: MainViewModel {
    
    func getModel() -> Model {
        Model(string: "mock model", source: .mock)
    }
}
