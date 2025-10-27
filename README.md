# B2C Platform - Flutter Reference Implementation

[![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Clean Architecture](https://img.shields.io/badge/architecture-Clean-green.svg)](ARCHITECTURE.md)

A modern, production-ready Flutter application demonstrating **Clean Architecture**, **Feature-Based** project structure, and industry best practices for building scalable mobile applications.

## 🎯 Project Overview

This project serves as a comprehensive reference implementation for senior Flutter developers, showcasing:

- ✨ **Clean Architecture** with clear separation of concerns
- 🏗️ **Feature-Based Structure** for improved modularity and scalability
- 🔄 **BLoC Pattern** for robust state management
- 🎨 **Modern UI/UX** with custom components
- 🧪 **Test-Driven Development** approach
- 📱 **Multi-platform** support (iOS, Android, Web, Desktop)

## 📐 Architecture

The project implements **Clean Architecture** principles combined with a **Feature-First** approach:

\`\`\`
lib/src/
├── core/                    # Core functionality (errors, usecases, platform)
├── common/                  # Shared utilities, widgets, and styles
└── features/                # Feature modules ⭐
    ├── auth/               # Authentication feature
    │   ├── data/           # Data sources, models, repositories impl
    │   ├── domain/         # Entities, repository interfaces, use cases
    │   └── presentation/   # UI, BLoC, widgets
    ├── user/               # User management feature
    ├── items/              # Items/Products feature
    ├── orders/             # Orders management feature
    ├── categories/         # Categories feature
    └── home/               # Home/Dashboard feature
\`\`\`

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md).

## 🚀 Features

- **Authentication**: Phone/OTP, JWT token management
- **User Management**: Profile, preferences, multi-city support
- **Items/Products**: CRUD operations, image upload, categories
- **Orders**: Order management, status tracking, history
- **Additional**: i18n, Firebase, Push notifications, Offline support

## 🛠️ Tech Stack

- **Flutter SDK**: 3.3.0+, **Dart**: 3.3.0+
- **State Management**: BLoC (flutter_bloc)
- **DI**: GetIt, **Networking**: Dio, **Navigation**: AutoRoute
- **Code Generation**: Freezed, json_serializable, build_runner
- **Testing**: Mocktail, bloc_test, flutter_test

## 📦 Setup

\`\`\`bash
# Clone repository
git clone https://github.com/yourusername/b2c-platform.git
cd b2c-platform

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run app
flutter run
\`\`\`

## 🧪 Testing

\`\`\`bash
flutter test
flutter test --coverage
\`\`\`

## 🏗️ Building

\`\`\`bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
\`\`\`

## 📝 Code Generation

\`\`\`bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode
flutter pub run build_runner watch
\`\`\`


## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

⭐ **If you find this helpful, give it a star!**
