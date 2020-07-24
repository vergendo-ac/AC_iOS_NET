import XCTest
@testable import AC_iOS_NET

final class AC_iOS_NETTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AC_iOS_NET().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
