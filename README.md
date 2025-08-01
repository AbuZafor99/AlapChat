# AlapChat - Flutter Firebase Chat Application

A modern, real-time chat application built with Flutter and Firebase, featuring Google Sign-In authentication and a beautiful UI design.

## 🚀 Features

- **Google Sign-In Authentication**: Secure login using Google accounts
- **Real-time Messaging**: Instant message delivery using Firebase
- **Modern UI Design**: Beautiful purple-themed interface with smooth animations
- **User Search**: Find and connect with other users
- **Profile Management**: View and manage user profiles
- **Cross-platform**: Works on iOS, Android, and Web

## 📱 Screenshots

- **Onboarding Screen**: Welcome interface with Google Sign-In
- **Home Screen**: Main dashboard with chat list and search
- **Chat Screen**: Individual chat interface with message bubbles

## 🛠️ Tech Stack

- **Frontend**: Flutter 3.8.1+
- **Backend**: Firebase
- **Authentication**: Firebase Auth + Google Sign-In
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage (for future image sharing)

## 📋 Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK
- Firebase project setup
- Google Cloud Console project
- Android Studio / VS Code

## 🔧 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/AbuZafor99/AlapChat
cd AlapChat
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication with Google Sign-In
4. Create a Firestore database
5. Enable Storage (optional for future features)

#### Configure Firebase
1. Download `google-services.json` for Android
2. Download `GoogleService-Info.plist` for iOS
3. Place them in the respective platform directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

#### Enable Google Sign-In
1. In Firebase Console, go to Authentication > Sign-in method
2. Enable Google Sign-In
3. Add your app's SHA-1 fingerprint for Android

### 4. Run the Application
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── my_app.dart              # App configuration and routing
├── services/
│   ├── auth.dart            # Authentication methods
│   └── database.dart        # Database operations
└── ui/screens/
    ├── onboarding_screen.dart  # Welcome screen
    ├── home_screen.dart        # Main dashboard
    └── chat_screen.dart        # Chat interface
```

## 🔑 Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  google_sign_in: ^6.1.6
  firebase_storage: ^latest
  image_picker: ^latest
  random_string: ^latest
```



## 👨‍💻 Author

**Your Name**
- GitHub: [AbuZafor99](https://github.com/AbuZafor99)

