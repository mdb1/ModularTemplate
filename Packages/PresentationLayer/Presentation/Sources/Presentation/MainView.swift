import SwiftUI
import Domain
import DesignSystem

// This is where the Screens live. Presentation depends on Domain, and on DesignSystem. It can also depend on CorePackages directly if needed.
// Each Screen will be composed of many DesignSystem components.
// The development team can decide which UI pattern (MVVM, MVP, VIP, VIPER, TCA, etc) to use.
// It's important to cover the state changes with unit tests.
// In this layer, we could also include:
// https://manu.show/2023-01-08-new-app-view-state/
// https://manu.showtroller/2023-03-04-view-state-controller/

public struct MainView: View {
    @StateObject private var viewModel = ViewModel()

    public init() {}

    /// Only used for the Previews
    init(dependencies: ViewModel.Dependencies) {
        _viewModel = StateObject(wrappedValue: ViewModel(dependencies: dependencies))
    }

    public var body: some View {
        VStack(spacing: 20) {
            Text("Modular iOS App")
                .font(.title)
                .bold()
            
            Text("Architecture Demo")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Fetch Data") {
                Task {
                    try await viewModel.fetchData()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            
            if let message = viewModel.message {
                Text(message)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            } else if let error = viewModel.error {
                Text(error)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview("Success") {
    // By using the dependencies approach, we can use in-line mocks for previews
    MainView(dependencies: .init(fetchData: {
        "Something Mocked"
    }))
}

#Preview("Error") {
    // By using the dependencies approach, we can use in-line mocks for previews
    MainView(dependencies: .init(fetchData: {
        throw NSError(domain: "", code: 1)
    }))
}
