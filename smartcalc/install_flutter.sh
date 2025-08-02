#!/bin/bash

echo "🚀 SmartCalc - Flutter Installation Script"
echo "=========================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed."
    echo "📥 Installing Flutter..."
    
    # Check OS and install Flutter accordingly
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "🍎 Detected macOS"
        if command -v brew &> /dev/null; then
            echo "📦 Installing Flutter via Homebrew..."
            brew install flutter
        else
            echo "❌ Homebrew not found. Please install Homebrew first:"
            echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "🐧 Detected Linux"
        echo "📥 Please install Flutter manually:"
        echo "   https://flutter.dev/docs/get-started/install/linux"
        exit 1
    else
        echo "❌ Unsupported OS. Please install Flutter manually:"
        echo "   https://flutter.dev/docs/get-started/install"
        exit 1
    fi
else
    echo "✅ Flutter is already installed"
fi

# Check Flutter version
echo "📋 Checking Flutter version..."
flutter --version

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ pubspec.yaml not found. Please run this script from the smartcalc directory."
    exit 1
fi

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Check for connected devices
echo "📱 Checking for connected devices..."
flutter devices

echo ""
echo "🎉 Setup complete!"
echo ""
echo "To run the app:"
echo "   flutter run"
echo ""
echo "To build for production:"
echo "   flutter build apk --release    # Android"
echo "   flutter build appbundle --release  # Android App Bundle"
echo "   flutter build ios --release    # iOS (macOS only)"
echo ""
echo "📚 For more information, see README.md" 