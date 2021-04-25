//
//  XCTestManifests.swift
//  Swiftject
//
//  Created by Alexander Kaverin on 25.04.2021.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftjectTests.allTests),
    ]
}
#endif
