# Dooss Business App

A comprehensive Flutter application for automotive business management and services.

## Features

- **Authentication System**: Complete login, registration, and password recovery flow
- **Car Management**: Browse, view details, and manage car listings
- **Product Catalog**: Comprehensive product browsing and details
- **Service Directory**: Find and connect with nearby automotive services
- **Interactive Maps**: Real-time location services and route planning
- **Chat System**: Direct communication between users and service providers
- **Video Reels**: Engaging content showcasing cars and services
- **Multi-language Support**: Arabic and English localization

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/dooss_business_app.git
```

2. Navigate to the project directory:
```bash
cd dooss_business_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── localization/
│   ├── network/
│   ├── routes/
│   ├── services/
│   ├── utiles/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── cars/
│   ├── chat/
│   ├── home/
│   ├── profile_dealer/
│   └── products/
└── main.dart
```

## Architecture

The project follows Clean Architecture principles with:
- **Presentation Layer**: UI components and state management using BLoC pattern
- **Business Logic Layer**: Cubits for state management
- **Data Layer**: API integration and local storage

## Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **BLoC/Cubit**: State management
- **Dio**: HTTP client
- **Go Router**: Navigation
- **Google Maps**: Location services
- **Shared Preferences**: Local storage
- **Flutter Secure Storage**: Secure data storage

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions, please contact the development team.
