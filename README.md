# Banking Architect: Clean Architecture & Security

A production-ready iOS banking application architecture demonstrating enterprise-grade design patterns, reactive programming, and high-security network layers.

## 🏗 Architecture & Patterns
* **Clean Architecture:** Strict separation of concerns using Domain, Presentation, and Data layers.
* **MVVM & Combine:** Unidirectional data flow using `@StateObject` and reactive view models.
* **Dependency Inversion (SOLID):** High-level Use Cases depend strictly on interface contracts (Protocols), completely isolating the business logic from the network/database implementation.
* **Dependency Injection:** Constructor injection utilized at the Composition Root to assemble the application safely.

## 🛡 Security Features
* **Custom URLSession:** Bypasses `URLSession.shared` to implement a custom delegate queue.
* **SSL Certificate Pinning:** Protects against Man-In-The-Middle (MITM) attacks by intercepting the authentication challenge and verifying the server's public key hash (Primary and Backup pin support for zero-downtime certificate rotation).

## 🚀 Data Flow
1. **View:** Triggers an intent (`loadData()`).
2. **ViewModel (Teller):** Subscribes to the Use Case via Combine.
3. **Use Case (Vault):** Executes business rules and requests data from the Repository Protocol.
4. **Repository (Front Door):** Fetches Data Transfer Objects (DTOs) from the network, maps them into pure Swift Domain Entities, and returns them up the stream.
