# Tajweed AI

A Flutter application for Tajweed learning and practice, built with modern architecture patterns and best practices.

## 🏗️ Architecture

**Tajweed AI** follows a **Clean Architecture** pattern with **Feature-Driven Development** approach, implementing the **BLoC (Business Logic Component)** pattern for state management.

### Architecture Overview

```
lib/
├── src/
│   ├── app/                    # Application layer
│   │   ├── binding/           # Dependency injection setup
│   │   ├── design/            # App themes and design system
│   │   ├── environment/       # Environment configuration
│   │   └── router/            # App routing with GoRouter
│   ├── base/                  # Base classes and utilities
│   │   ├── bloc/              # Base BLoC implementations
│   │   ├── dependencies/      # Base dependency injection
│   │   ├── extensions/        # Utility extensions
│   │   ├── helpers/           # Helper functions
│   │   └── screens/           # Base screen implementations
│   ├── core/                  # Core functionality
│   │   ├── api/               # API configuration and setup
│   │   ├── dependency/        # Core dependency injection
│   │   └── managers/          # Core managers (cache, connectivity)
│   └── features/              # Feature modules
│       ├── common/            # Shared feature components
│       └── shift_handover/    # Shift handover feature
│           ├── binding/       # Feature dependencies
│           ├── bloc/          # Feature business logic
│           ├── presentation/  # UI layer
│           └── domain/        # Business entities
```

### Key Architectural Patterns

- **Clean Architecture**: Separation of concerns with clear layer boundaries
- **Feature-Driven Development**: Each feature is self-contained with its own dependencies
- **BLoC Pattern**: State management using flutter_bloc
- **Dependency Injection**: Using GetIt for service locator pattern
- **Repository Pattern**: Abstracted data access layer
- **Router Pattern**: Centralized routing with GoRouter

## 🚀 Features

### Current Features
- **Responsive UI**: Material Design 3 with custom theming
- **Error Handling**: Comprehensive error handling and user feedback
- **State Management**: Reactive state management with BLoC pattern

### Planned Features
- **Tajweed Learning Modules**: Interactive lessons and exercises
- **Audio Integration**: Quran recitation with tajweed rules
- **Progress Tracking**: User learning progress and achievements
- **Offline Support**: Local data persistence with Isar database

## 🛠️ Technology Stack

### Core Dependencies
- **Flutter**: ^3.8.1 (Latest stable)
- **Dart**: ^3.8.1

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern implementation
- **equatable**: ^2.0.7 - Value equality support

### Navigation & Routing
- **go_router**: ^16.1.0 - Declarative routing solution

### Dependency Injection
- **get_it**: ^8.2.0 - Service locator for dependency injection

### Data & Storage
- **shared_preferences**: ^2.5.3 - Local key-value storage
- **flutter_secure_storage**: ^9.2.4 - Secure storage for sensitive data
- **isar**: ^3.1.0+1 - Fast local database

### Networking & Connectivity
- **generic_requester**: Custom HTTP client with lean footprint
- **connectivity_plus**: ^6.1.5 - Network connectivity monitoring

### Core Architecture Packages
- **cg_core_defs**: Essential core definitions and abstractions
- **generic_requester**: High-performance RESTful API performer

### Development Tools
- **flutter_lints**: ^6.0.0 - Code quality and style enforcement
- **isar_generator**: ^3.1.0+1 - Database code generation
- **flutter_launcher_icons**: ^0.14.4 - App icon management
- **flutter_native_splash**: ^2.4.6 - Splash screen management

## 🎨 Design System

- **Material Design 3**: Modern, adaptive design system
- **Custom Themes**: Light theme with consistent color palette
- **Responsive Layout**: Adaptive UI for different screen sizes
- **Accessibility**: Built-in accessibility support

## 📱 Platform Support

- **Android**: API level 26+ (Android 8.0+)
- **iOS**: Latest iOS versions
- **Web**: Not currently supported
- **Desktop**: Not currently supported

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.8.1
- Dart SDK ^3.8.1
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Nessryyne/Tajweed-AI.git
   cd tajweed_ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Install development dependencies**
   ```bash
   flutter pub get
   ```

2. **Run code analysis**
   ```bash
   flutter analyze
   ```

3. **Run tests**
   ```bash
   flutter test
   ```

## 🏗️ Project Structure

### Feature Module Structure
Each feature follows a consistent structure:
```
feature_name/
├── binding/           # Dependency injection
├── bloc/             # Business logic and state
├── domain/           # Business entities and models
└── presentation/     # UI components and screens
    ├── screen/       # Main screen
    ├── widgets/      # Reusable widgets
    └── snackbars/    # User feedback components
```

### Base Classes
- **BaseBloc**: Enhanced BLoC with lifecycle management
- **BlocProviderWidget**: Widget wrapper for BLoC providers
- **BaseScreen**: Common screen functionality

## 🔧 Configuration

### Environment Setup
The app supports multiple environments:
- **Development**: `Environment.dev`
- **Staging**: `Environment.staging`
- **Production**: `Environment.prod`

### API Configuration
- Centralized API configuration in `src/core/api/requester_config.dart`
- Environment-based API endpoints
- Request/response interceptors

## 📊 Performance

- **Lazy Loading**: Dependencies are registered as lazy singletons
- **State Optimization**: Smart rebuild strategies to minimize UI updates
- **Memory Management**: Proper lifecycle management in BLoCs
- **Image Optimization**: Oversized image handling and optimization

## 🧪 Testing

- **Unit Tests**: Business logic testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end testing
- **Code Coverage**: Comprehensive test coverage

## 📦 Build & Deployment

### Android
- **Build**: `flutter build apk --release`
- **Bundle**: `flutter build appbundle --release`
- **Icon**: Custom launcher icon support

### iOS
- **Build**: `flutter build ios --release`
- **Icon**: Custom app icon support
- **Splash**: Custom splash screen

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit your changes**: `git commit -m 'Add amazing feature'`
4. **Push to the branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

## 👥 Team

### 🏗️ **Architect & Lead Developer**
**Jewel Cheriaa**
- **Email**: jewelcheriaa@gmail.com
- **LinkedIn**: [Jewel Cheriaa](https://www.linkedin.com/in/jewel-cheriaa/)
- **Mobile**: +216 24 226 712
- **WhatsApp**: +33 7 43 10 44 25

**Expertise**: Senior iOS & Flutter Developer with 9+ years of experience
- **Architecture**: Clean Architecture, Feature-Driven Development
- **State Management**: BLoC, Riverpod, Provider, GetX
- **Performance**: Optimization, testing, automation
- **Leadership**: Tech Lead and Software Architect

### 🔧 **Contributor**
**Ibrahim Boudagga**
- **Email**: ibrahim.boudagga.cg@gmail.com
- **LinkedIn**: [Ibrahim Boudagga](https://www.linkedin.com/in/ibrahim-boudagga-496821334/)
- **Mobile**: +216 21 208 134
- **WhatsApp**: +216 21 208 134

**Expertise**:Flutter Developer with 4 years of experience
- **State Management**: BLoC, Riverpod, Provider, GetX
- **Performance**: Optimization, testing, automation
- **Focus**: Mobile app development and UI/UX implementation

## 🌟 Acknowledgments

- **Flutter Team**: For the amazing framework
- **BLoC Community**: For state management solutions
- **Open Source Contributors**: For various packages and tools

---

**Built with ❤️ using Flutter and Clean Architecture**
