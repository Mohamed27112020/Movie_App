# 🎬 Movie App

A modern Flutter application for browsing and managing movies with authentication powered by Supabase.

## ✨ Features

- 🔐 **User Authentication** - Secure login and signup with Supabase
  - Email/Password authentication
  - Google Sign-In integration
  - Persistent sessions
- 🎥 **Movie Management** - Browse and manage your movie collection
- 📱 **Cross-Platform** - Runs on iOS, Android, Web, Windows, macOS, and Linux
- 🎨 **Modern UI** - Clean and intuitive user interface
- 🔄 **State Management** - Built with BLoC/Cubit pattern for predictable state management

## 📸 Screenshots

_Coming soon..._

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- A Supabase account and project
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Mohamed27112020/Movie_App.git
cd Movie_App
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up Supabase**
   
   Create a `lib/core/supabase_config.dart` file with your Supabase credentials:
   
   ```dart
   class SupabaseConfig {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```
   
   Or use environment variables:
   - Copy `.env.example` to `.env`
   - Add your Supabase credentials to `.env`

4. **Run the app**
```bash
flutter run
```

## 🔧 Configuration

### Supabase Setup

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Project Settings → API
3. Copy your Project URL and anon/public key
4. Enable Email authentication in Authentication → Providers
5. (Optional) Set up Google OAuth for social login

### Database Schema

_Add your database schema here when ready_

```sql
-- Example tables
CREATE TABLE movies (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMP DEFAULT NOW()
);
```

## 🏗️ Project Structure

```
lib/
├── core/               # Core functionality
│   └── supabase_config.dart
├── features/           # Feature modules
│   ├── auth/          # Authentication
│   │   ├── cubit/
│   │   └── screens/
│   └── movies/        # Movie management
│       ├── cubit/
│       └── screens/
├── shared/            # Shared widgets and utilities
└── main.dart          # App entry point
```

## 📦 Dependencies

### Main Dependencies
- `flutter` - Flutter SDK
- `supabase_flutter` - Supabase client for Flutter
- `flutter_bloc` - State management
- `go_router` - Navigation (if used)

### Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_lints` - Linting rules

See [pubspec.yaml](pubspec.yaml) for complete list.

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🔒 Security

⚠️ **Important Security Notes:**

- Never commit API keys or secrets to Git
- Use `.env` files or secure config files (add to `.gitignore`)
- Enable Row Level Security (RLS) in Supabase
- Keep your `service_role` key private (server-side only)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Mohamed Ali**
- GitHub: [@Mohamed27112020](https://github.com/Mohamed27112020)

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - Beautiful native apps
- [Supabase](https://supabase.com) - Open source Firebase alternative
- [BLoC Library](https://bloclibrary.dev) - State management

## 📞 Support

If you have any questions or issues, please open an issue on GitHub.

---

Made with ❤️ using Flutter and Supabase
