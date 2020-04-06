import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EKNetworkModuleTests.allTests),
    ]
}
#endif
