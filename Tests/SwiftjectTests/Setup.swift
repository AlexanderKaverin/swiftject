//
//  Setup.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

@testable import Swiftject

extension DependencyName {
    static let localDataProvider: DependencyName = .init("local_data_provider")
    static let remoteDataProvider: DependencyName = .init("remote_data_provider")
    static let networkAvailabilityFlag: DependencyName = .init("network_availability_flag")
    static let mockBuildFlag: DependencyName = .init("mock_build_flag")
}

@ModuleBuilder fileprivate func dataModule() -> Module {
    Dependency.Provide<RESTClient> { ConcreteRESTCLient() }
    Dependency.Provide<DataProvider> { LocalDataProvider() }.named(.localDataProvider)
    Dependency.Provide<DataProvider> { RemoteDataProvider(client: $0.get()) }.named(.remoteDataProvider)
    Dependency.Provide<Repository> { ConcreteRepository() }
}

@ModuleBuilder fileprivate func viewModule() -> Module {
    Dependency.Provide<MainViewModel> { MainViewModelImpl() }.mode(.perInstance)
    Dependency.Provide<ViewModel> { ViewModel() }.mode(.perInstance)
}

@ModuleBuilder fileprivate func mockViewModule() -> Module {
    Dependency.Provide<MainViewModel> { MockMainViewModel() }.mode(.perInstance)
    Dependency.Provide<ViewModel> { ViewModel() }.mode(.perInstance)
}

func useDependencyInjection(mockBuild: Bool) {
    Container.add {
        dataModule()
        
        mockBuild
            ? mockViewModule()
            : viewModule()
    }
}
