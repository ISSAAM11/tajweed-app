# Tajweed AI

A Flutter application for Tajweed learning and practice, built with modern architecture patterns and best practices. This project serves as a foundation for developing Islamic learning applications with a focus on Quran recitation rules and tajweed principles.

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
│   │   ├── screens/           # Base screen implementations
│   │   └── datasource/        # Base data source implementations
│   ├── core/                  # Core functionality
│   │   ├── api/               # API configuration and setup
│   │   ├── dependency/        # Core dependency injection
│   │   └── managers/          # Core managers (cache, connectivity)
│   └── features/              # Feature modules
│       ├── common/            # Shared feature components
│       └── [feature_name]/    # Individual feature modules
│           ├── binding/       # Feature dependencies
│           ├── bloc/          # Feature business logic
│           ├── data/          # Data layer (models, datasources)
│           └── presentation/  # UI layer
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
- **Dependency Injection**: Robust DI system with GetIt
- **Network Management**: Connectivity monitoring and API configuration
- **Caching System**: Local data persistence with SharedPreferences
- **Secure Storage**: Sensitive data storage with Flutter Secure Storage
- **Custom Widgets**: Reusable UI components with consistent design

### Planned Features
- **Tajweed Learning Modules**: Interactive lessons and exercises
- **Audio Integration**: Quran recitation with tajweed rules
- **Progress Tracking**: User learning progress and achievements
- **Offline Support**: Local data persistence with Isar database
- **User Authentication**: Secure login and user management
- **Content Management**: Dynamic content delivery system

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

### Design Architecture
- **Material Design 3**: Modern, adaptive design system
- **Custom Themes**: Light theme with consistent color palette
- **Responsive Layout**: Adaptive UI for different screen sizes
- **Accessibility**: Built-in accessibility support

### Design Components
- **Color System**: Comprehensive color palette with semantic naming
- **Typography**: Custom font system with consistent sizing
- **Spacing**: Systematic spacing using design tokens
- **Components**: Reusable UI components with consistent behavior
- **Metrics**: Standardized dimensions for UI elements

### Custom Widgets
- **LoadingButton**: Interactive button with loading states
- **Spacing Widgets**: Horizontal and vertical spacing utilities
- **Widget Modifiers**: Extensive extension methods for common UI patterns

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
├── data/             # Data layer
│   ├── datasource/   # Data sources
│   ├── models/       # Data models
│   └── mock/         # Mock data for testing
└── presentation/     # UI components and screens
    ├── screen/       # Main screen
    ├── widgets/      # Reusable widgets
    └── snackbars/    # User feedback components
```

### Base Classes
- **BaseBloc**: Enhanced BLoC with lifecycle management and debugging
- **Feature**: Base widget for feature screens with dependency injection
- **Dependencies**: Abstract class for feature dependency management

### Core Infrastructure
- **GetItContainer**: Dependency injection container implementation
- **CacheManager**: Local data caching with SharedPreferences
- **ConnectivityMonitor**: Network connectivity monitoring
- **RequesterConfig**: API configuration and setup

## 🔧 Configuration

### Environment Setup
The app supports multiple environments:
- **Development**: `Environment.dev` - Development API endpoints
- **Staging**: `Environment.preprod` - Pre-production testing
- **Production**: `Environment.prod` - Production environment
- **Testing**: `Environment.test` - Testing environment
- **Mock**: `Environment.mock` - Mock data for development

### API Configuration
- Centralized API configuration in `src/core/api/requester_config.dart`
- Environment-based API endpoints with configurable timeouts
- Request/response interceptors for debugging and monitoring
- Mock data support for development and testing

### Design Configuration
- Centralized design tokens in `src/app/design/`
- Consistent spacing, colors, and typography
- Responsive breakpoints and adaptive layouts
- Theme switching support (currently light theme only)

## 📊 Performance

### Optimization Strategies
- **Lazy Loading**: Dependencies are registered as lazy singletons
- **State Optimization**: Smart rebuild strategies to minimize UI updates
- **Memory Management**: Proper lifecycle management in BLoCs
- **Image Optimization**: Oversized image handling and optimization
- **Widget Reuse**: Efficient widget rebuilding with BLoC patterns

### Monitoring & Debugging
- **Debugger Integration**: Comprehensive logging with color-coded output
- **Performance Overlay**: Built-in Flutter performance monitoring
- **State Tracking**: BLoC state change monitoring and debugging
- **Lifecycle Management**: App lifecycle state tracking and management

## 🧪 Testing

### Testing Strategy
- **Unit Tests**: Business logic testing with BLoC testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end testing
- **Code Coverage**: Comprehensive test coverage

### Testing Infrastructure
- **Test Environment**: Dedicated testing environment configuration
- **Mock Data**: Comprehensive mock data for testing scenarios
- **Test Utilities**: Base classes and utilities for testing

## 📦 Build & Deployment

### Android
- **Build**: `flutter build apk --release`
- **Bundle**: `flutter build appbundle --release`
- **Icon**: Custom launcher icon support
- **Splash**: Custom splash screen with native Android 12 support

### iOS
- **Build**: `flutter build ios --release`
- **Icon**: Custom app icon support
- **Splash**: Custom splash screen

### Build Scripts
- **Launcher Icon**: `./scripts/launcher_icon.sh`
- **Splash Screen**: `./scripts/bsplash_sceeen.sh`
- **Remove Splash**: `./scripts/rsplash_screen.sh`

## 🔒 Security

### Data Protection
- **Secure Storage**: Sensitive data stored using Flutter Secure Storage
- **Network Security**: HTTPS-only API communication
- **Input Validation**: Comprehensive input validation and sanitization
- **Error Handling**: Secure error messages without information leakage

## 🌐 Internationalization

### Localization Support
- **Multi-language**: Framework ready for multiple languages
- **RTL Support**: Right-to-left language support
- **Cultural Adaptation**: Design adapted for Islamic cultural context


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

**Expertise**: Flutter Developer with 4 years of experience
- **State Management**: BLoC, Riverpod, Provider, GetX
- **Performance**: Optimization, testing, automation
- **Focus**: Mobile app development and UI/UX implementation

## 🌟 Acknowledgments

- **Flutter Team**: For the amazing framework
- **BLoC Community**: For state management solutions
- **Open Source Contributors**: For various packages and tools
- **Islamic Scholars**: For tajweed knowledge and guidance

---

**Built with ❤️ using Flutter**
