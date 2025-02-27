# Contributing

This is a living document representing some guidelines that will help our team do great work, and keep consistency in the codebase and the systems over time.

## Code Quality Principles

- `Naming` → Explicitness, brevity, and consistency.
- `Commenting` → Exist to help future readers (including yourself).
- `Testing`:
    - Code isn’t high quality without tests.
    - Unit testing is a baseline tool for sustainable engineering.
    - Tests should be fast. Inject dependencies to favor decoupling.
    - Run tests often. Main should always be green.
- `Cleverness` → Favor explicitness and simplicity over cleverness. Make things easier to maintain.
- `Code Reviews are mandatory`:
    - Is it correct?
    - Is it clear?
    - Is it consistent with the codebase?
    - Is it tested?
    - Be polite. We are humans and we all play for the same team.
    
### Swift Style Guide
Follow Swift's [API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) whenever possible.

- Types start with uppercased letters. Functions, variables, and enums start with lowercased letters.
- Default to `struct` unless you need a class-only feature.
- Mark classes as `final` unless you want inheritance.
- Use `guard` to exit functions early.
- Avoid `self.` whenever possible.

## Git Strategy

We follow the [Github flow](https://githubflow.github.io/) strategy based on it's simplicity. The only difference is that our principal branch is called `main` instead of `master`.

All the changes to the codebase must be reviewed by our peers before merging to the `main` branch.

We keep the `main` branch always `green` by ensuring the new changes don't break previous functionality.

## Testing Strategy

For now, we will value unit-testing over every other form of tests. We should strive to always test the business logic of the new changes while not breaking the previously coded unit tests.

In the future, we will introduce other forms of testing (UI, Snapshot, Integration testing, etc).

## Coding Conventions

We have a formatter and a linter set up in the repository that will enforce must of the conventions. Checkout the rules we have by looking at the `.swiftformat` and/or the `.swiftlint.yml` files.

### SwiftUI's View/ViewModel

To provide a consistent feeling across the app, we will use namespaces for the view models.

Example:

```swift
// In HomeView+ViewModel.swift
extension HomeView {
    @MainActor 
    final class ViewModel: ObservableObject {
        private let dependencies: Dependencies
        
        init(dependencies: Dependencies = .default) {
            self.dependencies = dependencies
        }
    }
}

extension HomeView.ViewModel {
    // Functionality
}

extension HomeView.ViewModel {
    struct Dependencies {
        // Dependencies as functions

        static let `default`: Dependencies = Dependencies()
    }
}

...

// In HomeView.swift
@StateObject private var viewModel: ViewModel = .init()
```

# Dependency Management

We use local packages for our modules.

## Dependency Management Between Modules

Be mindful of dependencies between modules. A good rule of thumb is:

- Core modules should have minimal or no dependencies on other modules
- Domain modules can depend on Core modules. Domain cannot depend on DesignSystem.
- UI/Presentation modules can depend on Domain modules and Core Modules.

This creates a clean dependency graph that avoids circular dependencies.

### CoreLayer

This layer is for the foundational packages.

Every other package can import a package from this layer (including other Core Packages).

Think of this layer as the fundamentals for your app.

Examples include:

- API Models: The decodable object representation of the backend data. More info in [UI vs API Models](/2023-08-25-ui-vs-api-models-different-layers/)
- DesignSystem: All the tokens (colors, fonts, sizes, images), and the reusable components of the app (buttons, inputs, toggles, etc). This layer is imported directly from the `Presentation` layer.
  - [Components](/2023-01-04-new-app-components/)
  - [Toasts](/2023-03-08-new-app-toasts/)
  - [Constants](/2022-12-24-new-app-constants/)
  - [ViewModifiers](/2023-01-03-new-app-view-modifiers/)
- Logger: A logging mechanism. I find [this one](/2024-03-19-new-app-os-log/) really useful.
- Networking: Here you could either import a third party library, or create your own implementation. For new projects, I usually start with something [like this](https://github.com/mdb1/CoreNetworking) and only evolve as necessary.
- Storage: Something simple as a [UserDefaults wrapper](/2023-04-18-user-preferences/) to begin with, it can evolve to support caching mechanism when needed.
- Utilities: Extensions useful across the app. Examples:
  - Strings+Extension
  - [DateFormatters](/2023-01-10-new-app-date-formatters/)
  - [JSON+Extension](/2023-01-10-new-app-json-encoder-decoder/)
  - [NumberFormatters](/2023-06-12-new-app-number-formatters/)
  - [NotificationCenter](/2023-08-12-new-app-notification-center-protocols/)
- Testing: Useful extensions to enhance XCTest. More info in: [Unit tests helpers](/2023-02-02-new-app-testing-helpers/)

### Domain Layer

This is where the business logic lives. Domain should only depend on Core packages.

If in need in the future, you can split up the Domain modules into multiple ones. Maybe one per feature.

This is the layer that it's most important to cover with unit tests.

Some advice on how to achieve that in:
- [Enhancing Testability with Protocols](/2023-02-13-enhancing-testability-with-protocols/)
- [Enhancing Testability without Protocols](/2023-02-03-enhancing-testability-without-protocols/)

This layer is also where the `World` object lives from: [Centralized Dependencies](/2024-02-29-centralized-dependencies/)

In this layer, you will also have the:
- Services (import Networking to talk with the backend)
- Repositories (import Storage to persist data)
- Real app models (with their mappers from the API models)
- Extensions on the models to represent their capabilities

From Domain Driven Design:
```yml
A model is a simplification.

1. The model and the heart of the design shape each other.
2. The model is the backbone of a language used by all team members.
3. The model is distilled knowledge.

Developers have to steep themselves in the domain to build up
knowledge of the business.
```

### Presentation Layer

This is where the Screens live. Presentation depends on Domain, and on DesignSystem. It can also depend on CorePackages directly if needed.

Each Screen will be composed of many DesignSystem components.

The development team can decide which UI pattern (MVVM, MVP, VIP, VIPER, TCA, etc) to use.

It's important to cover the state changes with unit tests.

In this layer, we could also include:

- [ViewState](2023-01-08-new-app-view-state/)
- [ViewStateController](/2023-03-04-view-state-controller/)

## Third Party dependencies

Third party SDKs should be in the Foundation layer, however, we need to create a wrapper SDK (following the adapter and factory patterns) for each library. So, for example, the Analytics package would import FirebaseAnalytics, and only expose the necessary methods, without any hint to the use of Firebase under the hood.