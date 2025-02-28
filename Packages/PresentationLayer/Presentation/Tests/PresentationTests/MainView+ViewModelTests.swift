@testable import Presentation
import XCTest

final class MainViewViewModelTests: XCTestCase {
    @MainActor
    func testMessageIsSetWhenFetchDataSucceeds() async throws {
        // Given
        let expectedMessage = "Mock"
        let sut = MainView.ViewModel(dependencies: .init(fetchData: {
            expectedMessage
        }))
        XCTAssertNil(sut.message)

        // When
        try await sut.fetchData()

        // Then
        XCTAssertEqual(sut.message, expectedMessage)
        XCTAssertNil(sut.error)
    }

    @MainActor
    func testErrorIsSetWhenFetchDataThrows() async throws {
        // Given
        let error = NSError(domain: "", code: 1)
        let sut = MainView.ViewModel(dependencies: .init(fetchData: {
            throw error
        }))
        XCTAssertNil(sut.error)

        // When
        try await sut.fetchData()

        // Then
        XCTAssertEqual(sut.error, error.localizedDescription)
        XCTAssertNil(sut.message)
    }
}
