import XCTest
@testable import EKNetworkModule

final class EKNetworkModuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EKNetworkModule().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
