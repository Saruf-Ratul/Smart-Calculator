# SmartCalc - Modern Calculator App

A powerful, fast, and reliable calculator app with scientific functions, history tracking, and theme customization for both Android and iOS platforms.

## 🚀 Features

### Core Features
- **Basic Arithmetic Operations**: Addition, subtraction, multiplication, division
- **Scientific Mode**: Trigonometric functions (sin, cos, tan), logarithms, square root
- **Calculation History**: View and copy past calculations
- **Theme Support**: Light and dark themes
- **Haptic Feedback**: Tactile response for button presses
- **Copy to Clipboard**: Easy result copying
- **Responsive Design**: Works on all screen sizes

### Premium Features (Coming Soon)
- **Ad-Free Experience**: Remove banner ads
- **Custom Themes**: Additional color schemes
- **Currency Converter**: Built-in unit conversion
- **Advanced Functions**: More scientific operations

## 📱 Screenshots

*Screenshots will be added after first build*

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics
- **Ads**: Google AdMob
- **Vibration**: flutter_vibrate
- **Clipboard**: clipboard

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

1. **Flutter SDK** (3.0.0 or higher)
2. **Dart SDK** (3.0.0 or higher)
3. **Android Studio** or **VS Code**
4. **Android SDK** (for Android development)
5. **Xcode** (for iOS development, macOS only)

## 🚀 Installation

### 1. Install Flutter

```bash
# macOS (using Homebrew)
brew install flutter

# Or download from https://flutter.dev/docs/get-started/install
```

### 2. Clone the Repository

```bash
git clone <repository-url>
cd smartcalc
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Configure Firebase (Optional)

If you want to use Firebase Analytics and Crashlytics:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps to your Firebase project
3. Download and add the configuration files:
   - `google-services.json` to `android/app/`
   - `GoogleService-Info.plist` to `ios/Runner/`

### 5. Configure AdMob (Optional)

For ad functionality:

1. Create an AdMob account at [AdMob Console](https://admob.google.com/)
2. Create banner ad units for Android and iOS
3. Replace the test ad unit IDs in `lib/providers/ads_provider.dart` with your actual IDs

## 🏃‍♂️ Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle (Recommended for Play Store)
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── calculation_history.dart
├── providers/
│   ├── calculator_provider.dart
│   ├── theme_provider.dart
│   └── ads_provider.dart
├── screens/
│   └── calculator_screen.dart
├── widgets/
│   ├── calculator_display.dart
│   ├── calculator_buttons.dart
│   ├── scientific_buttons.dart
│   └── history_drawer.dart
├── services/
├── utils/
│   └── theme_data.dart
└── assets/
    ├── images/
    └── fonts/
```

## 🎨 Customization

### Themes
Modify `lib/utils/theme_data.dart` to customize colors and styling.

### Ad Configuration
Update ad unit IDs in `lib/providers/ads_provider.dart`.

### App Icon
Replace the default Flutter icon in:
- `android/app/src/main/res/mipmap-*`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## 📊 Analytics & Monitoring

The app includes Firebase Analytics and Crashlytics for monitoring:
- User engagement metrics
- App performance
- Crash reports
- User behavior insights

## 🚀 Deployment

### Google Play Store

1. **Build App Bundle**:
   ```bash
   flutter build appbundle --release
   ```

2. **Create Play Console Account**:
   - Go to [Google Play Console](https://play.google.com/console)
   - Create a developer account ($25 one-time fee)

3. **Upload App**:
   - Create new app in Play Console
   - Upload the generated `.aab` file
   - Fill in store listing details
   - Set up content rating
   - Configure pricing & distribution

4. **Required Assets**:
   - App icon (512x512 PNG)
   - Feature graphic (1024x500 JPG/PNG)
   - Screenshots (minimum 2, recommended 6-8)
   - Privacy policy (required for ads)

### Apple App Store

1. **Build iOS App**:
   ```bash
   flutter build ios --release
   ```

2. **Create App Store Connect Account**:
   - Go to [App Store Connect](https://appstoreconnect.apple.com/)
   - Enroll in Apple Developer Program ($99/year)

3. **Upload App**:
   - Use Xcode or Application Loader
   - Submit for review
   - Configure app metadata and assets

## 📈 Business Goals

- **Target**: 100,000+ downloads in first 12 months
- **Monetization**: Ad-supported free version + premium upgrade
- **Platforms**: Android (Google Play) and iOS (App Store)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact: [your-email@example.com]

## 🔄 Version History

- **v1.0.0**: Initial release with basic calculator functionality
- **v1.1.0**: Added scientific mode and history
- **v1.2.0**: Added theme support and ads integration

---

**Note**: This is a production-ready calculator app designed for commercial deployment. Make sure to test thoroughly on multiple devices before releasing to app stores. # Smart-Calculator
