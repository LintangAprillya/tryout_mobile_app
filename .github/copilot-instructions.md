# Copilot Instructions untuk Tryout Apps

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Project Overview
Ini adalah aplikasi mobile tryout/ujian berbasis Flutter untuk platform Android dan iOS.

## Tech Stack
- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Storage**: SharedPreferences, SQLite (sqflite)
- **HTTP Client**: http package
- **Internationalization**: intl

## Struktur Project
- `lib/screens/` - UI screens (home, login, exam, results, etc.)
- `lib/widgets/` - Reusable widgets
- `lib/models/` - Data models (Question, Exam, User, Result)
- `lib/services/` - Business logic (API, Database, Auth)
- `lib/providers/` - State management providers
- `lib/utils/` - Helper functions, constants
- `assets/` - Images, fonts, data files

## Coding Standards
- Gunakan Dart naming conventions (camelCase untuk variables, PascalCase untuk classes)
- Pisahkan UI dari business logic
- Gunakan const constructors untuk widget yang immutable
- Implement error handling yang proper
- Tambahkan comments untuk logika yang kompleks

## Key Features
1. Authentication (login/register)
2. Bank soal tryout
3. Timer untuk ujian
4. Review jawaban
5. Scoring & analytics
6. History hasil tryout

## Best Practices
- Selalu gunakan `flutter pub get` setelah menambah dependencies
- Test di emulator sebelum production
- Gunakan async/await untuk operasi asynchronous
- Implement loading states dan error handling
