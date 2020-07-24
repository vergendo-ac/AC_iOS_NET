import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AC_iOS_NETTests.allTests),
    ]
}
#endif
