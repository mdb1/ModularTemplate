import Foundation
import Networking
import Utilities
import Logger

/*
 This is where the business logic lives. Domain should only depend on Core packages.

 If in need in the future, you can split up the Domain modules into multiple ones. Maybe one per feature.

 This is the layer that it's most important to cover with unit tests.

 Some advice on how to achieve that in:
 - [Enhancing Testability with Protocols](https://manu.show/2023-02-13-enhancing-testability-with-protocols/)
 - [Enhancing Testability without Protocols](https://manu.show/2023-02-03-enhancing-testability-without-protocols/)

 This layer is also where the `World` object lives from: [Centralized Dependencies](https://manu.show/2024-02-29-centralized-dependencies/)

 In this layer, you will also have the:
 - Services (import Networking to talk with the backend)
 - Repositories (import Storage to persist data)
 - Real app models (with their mappers from the API models)
 - Extensions on the models to represent their capabilities
 */

public struct DomainService {
    public init() {

    }

    // This should use Networking
    public func getData() async throws -> String {
        "Hola"
    }
}
