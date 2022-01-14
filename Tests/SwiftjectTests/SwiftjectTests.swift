//
//  SwiftjectTests.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

import XCTest
@testable import Swiftject

final class SwiftjectTests: XCTestCase {
        
    func testWithConnectivity() {
        useDependencyInjection(mockBuild: false)
        
        Container.add {
            Dependency.Provide<Bool> { true }.named(.networkAvailabilityFlag)
        }
        
        let viewModel: MainViewModel = Container.instance.resolve()
        
        let expectedSource: ModelSource = .remote
        let actualSource = viewModel.getModel().source
        XCTAssertEqual(expectedSource, actualSource)
    }
    
    func testWithoutConnectivity() {
        useDependencyInjection(mockBuild: false)
        
        Container.add {
            Dependency.Provide<Bool> { false }.named(.networkAvailabilityFlag)
        }
        
        let viewModel: MainViewModel = Container.instance.resolve()
        
        let expectedSource: ModelSource = .local
        let actualSource = viewModel.getModel().source
        XCTAssertEqual(expectedSource, actualSource)
    }
    
    func testMock() {
        useDependencyInjection(mockBuild: true)
        
        Container.add {
            Dependency.Provide<Bool> { false }.named(.networkAvailabilityFlag)
        }
        
        let viewModel: MainViewModel = Container.instance.resolve()
        
        let expectedSource: ModelSource = .mock
        let actualSource = viewModel.getModel().source
        XCTAssertEqual(expectedSource, actualSource)
    }

    static var allTests = [
        ("withConnectivity", testWithConnectivity),
        ("withoutConnectivity", testWithoutConnectivity),
        ("mock", testMock)
    ]
}
