# CG Core Definitions

A comprehensive Flutter package that provides essential core definitions, utilities, and abstractions for building robust Flutter applications. This package implements the Strategy Pattern and provides a solid foundation for scalable app development.

## Features

### 🔧 **Core Components**
- **Observable Pattern**: Reactive state management with automatic UI updates
- **Dependency Injection**: Flexible DI container with multiple registration strategies
- **Cache Management**: Abstract cache interface for data persistence
- **Connectivity Monitoring**: Real-time network status tracking
- **Location Services**: Geolocation and place management utilities
- **Input Controls**: Streamlined form input management
- **Debugging Tools**: Colored console logging for development

### 🎯 **Design Patterns**
- **Strategy Pattern**: Abstract interfaces for all major components
- **Observer Pattern**: Reactive programming with Observable/Observer widgets
- **Factory Pattern**: Flexible object creation through DI container
- **Either Pattern**: Functional programming with Left/Right containers

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  cg_core_defs: ^1.0.0
```

## Usage

### 🔄 Observable Pattern

The Observable pattern provides reactive state management with automatic UI updates.

```dart
import 'package:cg_core_defs/components/observable.dart';

// Create an observable value
final counter = Observable<int>(0);

// Update the value (triggers listeners automatically)
counter.value = 5;

// Use in UI with Observer widget
Observer(
  observes: counter,
  builder: (context, value) => Text('Count: $value'),
)

// Useful extensions
counter.updateIfDifferent(10); // Only updates if different
```

### 🏗️ Dependency Injection

Flexible DI container supporting multiple registration strategies.

```dart
import 'package:cg_core_defs/dependency_injection/di_container.dart';

// Register dependencies
container.registerFactory<ApiService>(() => ApiService());
container.registerSingleton<CacheManager>(SharedPrefsCacheManager());

// Retrieve dependencies
final apiService = container.get<ApiService>();
final cacheManager = container.getNamed<CacheManager>('shared_prefs');
```

### 💾 Cache Management

Abstract cache interface for data persistence.

```dart
import 'package:cg_core_defs/cache/cache_manager.dart';

class MyCacheManager implements CacheManager<MyActor> {
  @override
  MyActor get actor => _actor;

  // Implement cache operations
  @override
  Future<bool> setString(String key, String value) async {
    // Implementation
  }

  @override
  String? getString(String key) {
    // Implementation
  }
}
```

### 📡 Connectivity Monitoring

Real-time network status tracking with connection type detection.

```dart
import 'package:cg_core_defs/connectivity/connectivity_monitor.dart';

class MyConnectivityMonitor extends ConnectivityMonitor {
  @override
  void startMonitoring() {
    super.startMonitoring();
    // Start monitoring implementation
  }
}

// Usage
final monitor = MyConnectivityMonitor();
monitor.startMonitoring();

// Check connection status
if (monitor.isConnected) {
  if (monitor.isWifi) {
    // Handle WiFi connection
  } else if (monitor.isMobile) {
    // Handle mobile connection
  }
}
```

### 📍 Location Services

Geolocation and place management utilities.

```dart
import 'package:cg_core_defs/location/location_plugin.dart';
import 'package:cg_core_defs/location/place_detail.dart';

class MyLocationPlugin implements LocationPlugin {
  @override
  Future<bool> hasPermission() async {
    // Implementation
  }

  @override
  Future<GeoCoordinates> getLocation() async {
    // Implementation
  }
}

// Place details
final place = PlaceDetail(
  name: 'Central Park',
  latitude: 40.7829,
  longitude: -73.9654,
  address: 'New York, NY',
);
```

### 📝 Input Controls

Streamlined form input management with automatic disposal.

```dart
import 'package:cg_core_defs/core/models/input_control.dart';

// Create single input control
final emailControl = InputControl.single();

// Create multiple input controls
final controls = InputControl.generate(3);

// Use in TextField
TextField(
  controller: emailControl.controller,
  focusNode: emailControl.node,
)

// Dispose when done
emailControl.dispose();
controls.disposeAll();
```

### 🔍 Core Extensions

Useful extensions for common operations.

```dart
import 'package:cg_core_defs/core/extensions/iterable_ext.dart';

final list = [1, 2, 3, 4, 5];

// Get second and third elements
final second = list.second; // 2
final third = list.third;   // 3

// Conditional filtering
final filtered = list.keepWhere(
  (e) => e > 2,
  onlyIf: (e) => e > 0,
);
```

### 🎲 Either Pattern

Functional programming with Left/Right containers for error handling.

```dart
import 'package:cg_core_defs/core/containers/either.dart';

Either<String, int> divide(int a, int b) {
  if (b == 0) {
    return Either.left('Division by zero');
  }
  return Either.right(a ~/ b);
}

// Usage
final result = divide(10, 2);
result.fold(
  (error) => print('Error: $error'),
  (value) => print('Result: $value'),
);
```

### 🐛 Debugging Tools

Colored console logging for development.

```dart
import 'package:cg_core_defs/helpers/debugging_printer.dart';

Debugger.green('Success message');
Debugger.red('Error message');
Debugger.blue('Info message');
Debugger.magenta('Warning message');
Debugger.yellow('Important notice');
```

## Architecture

This package follows clean architecture principles with:

- **Abstract Interfaces**: All components define abstract interfaces for flexibility
- **Strategy Pattern**: Different implementations can be swapped easily
- **Separation of Concerns**: Each module has a specific responsibility
- **Reactive Programming**: Observable pattern for state management
- **Dependency Injection**: Loose coupling through DI container

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions, please open an issue on the GitHub repository.

## Contact
**Jewel Cheriaa**
- Email: jewelcheriaa@gmail.com
- LinkedIn: [Jewel Cheriaa](https://www.linkedin.com/in/jewel-cheriaa/)
- Mobile: +216 24 226 712
- WhatsApp: +33 7 43 10 44 25

For more information about my Flutter expertise, check out my projects:
- [Lean Requester](https://github.com/Jewelch/lean_requester) - Lightweight HTTP requester with lean footprint (For experts)
- [Generic Requester](https://github.com/Jewelch/generic_requester) - High-performance RESTful API performer (For beginners)
- [Clean Architecture Flutter](https://github.com/Jewelch/clean_architecture_flutter) - Clean Architecture implementation for Flutter
- [Cera Electornique Diffiseur](https://github.com/Jewelch/cera_electornique_diffiseur) - Smart fragrance diffuser with Flutter mobile app
- [Obvious Architecture](https://github.com/Jewelch/ObviousArchitecture) - Simplified architecture patterns for Flutter

### Get in Touch

Feel free to reach out if you have any questions, suggestions, or would like to contribute to this project. I'm always open to collaboration and feedback!

## Developer Profile

### Introduction
Senior iOS & Flutter Developer (TUNISIA) - Bilingual in French and English  
Tech Lead and Software Architect  
Certified Trainer at IQClass and VosCours  
9 years of experience | 50+ applications created | 35+ still live on App Store

### Technical Expertise
Passionate and results-driven, with a solid track record of creating high-quality applications. Expert in:
- Generic programming
- Clean Architecture
- UIKit, SwiftUI, Combine (iOS)
- State Management Patterns (BLoC, Riverpod, Provider, Getx, Mobx, Modular)
- Automation and testing (Unit, UI, Integration, E2E)
- Performance optimization
- Code maintainability
- Complex system integration

### Notable Applications
* My Swiss Keeper (Switzerland) - [App Store](https://apps.apple.com/fr/app/my-swiss-keeper/id1617620449)
* RTA Dubai (UAE Roads & Transport Authority) (+1M users) - [App Store](https://apps.apple.com/ae/app/rta-dubai/id426109507)
* Maskan (UAE Federal Tax Authority) (+1K users) - [App Store](https://apps.apple.com/us/app/maskan-fta/id6478710219)
* IRP AUTO Santé (FRANCE) (+100K users) - [App Store](https://apps.apple.com/fr/app/irp-auto-sant%C3%A9/id948623366?l=en) | [Play Store](https://play.google.com/store/apps/details?id=com.irpauto.sante&hl=en_US)
* Ville de Marseille (FRANCE) (+10K users) - [App Store](https://apps.apple.com/fr/app/ville-de-marseille/id1267540404?platform=iphone)
* Zenpark - Parkings (FRANCE) (+500K users) - [App Store](https://apps.apple.com/fr/app/zenpark-parkings/id757934388)
* iHealth MyVitals (FRANCE) (+100K users) - [App Store](https://apps.apple.com/us/app/ihealth-myvitals/id1532014748)
* Rides2U (USA) (+4K users) - [App Store](https://apps.apple.com/us/developer/rides2u-llc/id1616957681) | [Play Store](https://play.google.com/store/apps/dev?id=7213610952804159810)
* Halal App (KSA) - [App Store](https://apps.apple.com/us/app/halal-app-%D8%AD%D9%84%D8%A7%D9%84/id1570293278)
* WALLPOST Software (USA) (+2K users) - [App Store](https://apps.apple.com/fr/app/wallpost-software/id1044979110)
* TLFnet (+2K users) - [Play Store](https://play.google.com/store/apps/details?id=com.tlfnet)
* Sketch AI: Drawing to Art (TURKEY) - [App Store](https://apps.apple.com/us/app/sketch-ai-drawing-to-art/id6447612551)
* Aligneurs Français (FRANCE) - [App Store](https://apps.apple.com/fr/app/aligneurs-francais/id1630781596?platform=iphone)
* Turaqi Captain & Client (KSA) - [App Store](https://apps.apple.com/fr/developer/atallah-almotairi/id1535395336)
* CODE: QR & Barcode Reader (FRANCE) - [App Store](https://apps.apple.com/us/app/code-qr-and-barcode-reader/id1073953713)
* KingaSafety (USA) - [App Store](https://apps.apple.com/us/app/kinga-safety/id6443869502)

### Leadership and Expertise
In addition to my technical expertise, I bring strong leadership and teamwork capabilities, having held key positions in several organizations:
- QoreVirtual (USA) - iOS, Android and Flutter Software Architect
- BMW (Germany) - Senior Android Developer
- SCUB (France) - Flutter Tech Lead
- Be-ys Software (France) - Flutter & iOS Tech Lead
- WiMobi (Tunisia) - iOS Tech Lead

---

**Made with ⏳ patience by Jewel Cheriaa**
