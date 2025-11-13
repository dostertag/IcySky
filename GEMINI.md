# GEMINI.md

## Project Overview

This project is a modern, beautiful Bluesky client for iOS named IcySky. It is built with SwiftUI and leverages the latest iOS 26 SDK features, including Liquid Glass effects for a stunning user interface. The application is a native iOS client for the decentralized social network, Bluesky, which is built on the AT Protocol.

The project follows a modular architecture, separating UI components from business logic using Swift Package Manager. It uses the `ATProtoKit` for AT Protocol integration and `KeychainSwift` for secure storage of authentication credentials.

## Building and Running

To build and run the project, you will need:

*   **iOS 26.0+**
*   **Xcode 26.0+** with iOS 26 SDK
*   **Swift 6.2+**

1.  Clone the repository:
    ```bash
    git clone https://github.com/Dimillian/IcySky.git
    ```

2.  Open the project in Xcode:
    ```bash
    cd IcySky
    open IcySky.xcodeproj
    ```

3.  Build and run the project on an iOS 26 simulator or a compatible device.

## Development Conventions

The project follows a "no-ViewModel" approach, embracing SwiftUI's native patterns:

*   Views are treated as pure state expressions.
*   Dependency injection is managed using SwiftUI's `Environment`.
*   Local state is managed with enums.
*   Business logic is encapsulated in service classes.

The codebase is organized into two main Swift packages:

*   **Features Package**: This package contains all the UI components and views, organized by feature (e.g., `AuthUI`, `FeedUI`, `PostUI`). It also includes a custom `DesignSystem` with reusable components.
*   **Model Package**: This package holds the core business logic and data models. It includes the network layer for interacting with the AT Protocol, data models, state management, and authentication logic.

For more detailed development guidelines, refer to the `CLAUDE.md` file in the project's root directory.
