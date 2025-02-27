import Domain
import SwiftUI

extension MainView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var message: String?
        @Published var error: String?
        private let dependencies: Dependencies

        init(dependencies: Dependencies = .default) {
            self.dependencies = dependencies
        }
    }
}

extension MainView.ViewModel {
    func fetchData() async throws {
        do {
            message = try await dependencies.fetchData()
        } catch {
            self.error = error.localizedDescription
        }
    }
}

extension MainView.ViewModel {
    struct Dependencies {
        var fetchData: () async throws -> String

        static let `default`: Dependencies = Dependencies(
            fetchData: {
                try await DomainService().getData()
            }
        )
    }
}
