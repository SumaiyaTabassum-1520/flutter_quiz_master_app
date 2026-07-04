# 🧠 Quiz Master

A polished, fully offline Flutter quiz application built to practice real-world app development skills: **state management, local persistence, declarative routing, custom UI/UX, and clean data modeling.**

## ✨ Features

- **🎨 Light/Dark Theme Toggle** — one-tap switch in the AppBar, persisted with `SharedPreferences` so it survives a full app restart.
- **📊 Live Statistics Dashboard** — Total Quiz Attempts, Highest Score, and Last Score, read directly from local storage.
- **🗂️ 5 Quiz Categories** — Sports 🏀, Science 🔬, Technology 💻, History 📜, and General Knowledge 🧠 — each with 5 questions.
- **📝 Dynamic Quiz Flow** — question counter, animated progress bar, single-selection MCQ options with highlight feedback, and a `Next` / `Finish` button that adapts to the current question.
- **🏆 Detailed Result Screen** — total questions, correct/wrong answers, final score, and percentage, with **Play Again** and **Back to Home** actions.
- **🕘 Quiz History** — the last 10 results are stored locally (newest first) and shown on the dashboard.
- **📴 100% Offline** — no API calls; all quiz content and history are handled locally.

## 🛠️ Tech Stack

| Concept | Implementation |
|---|---|
| Routing | [`go_router`](https://pub.dev/packages/go_router) (declarative routing) |
| Local Storage | [`shared_preferences`](https://pub.dev/packages/shared_preferences) |
| State Management | `ChangeNotifier` (`ThemeController`) for theme state |
| Architecture | Clean separation: `models/`, `services/`, `data/`, `screens/`, `widgets/`, `routes/`, `theme/` |

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/
│   ├── question.dart          # MCQ question model
│   ├── quiz_category.dart     # Category model
│   └── quiz_result.dart       # Quiz attempt result model (+ JSON serialization)
├── services/
│   ├── storage_service.dart   # SharedPreferences wrapper (stats + history)
│   └── theme_controller.dart # Theme state management
├── data/
│   └── quiz_data.dart         # All categories & questions (local, no API)
├── screens/
│   ├── home_screen.dart       # Dashboard: stats, categories, history
│   ├── quiz_screen.dart       # Question flow
│   └── result_screen.dart     # Score summary
├── widgets/
│   ├── category_card.dart
│   ├── stat_card.dart
│   └── option_tile.dart
├── routes/
│   └── app_router.dart        # GoRouter route table
└── theme/
    └── app_theme.dart         # Light & Dark ThemeData
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.3.0`
- Dart SDK `>=3.3.0`

### Installation

```bash
git clone https://github.com/<your-username>/flutter_quiz_master_app.git
cd flutter_quiz_master_app
flutter pub get
flutter run
```

## 🧩 Key Design Decisions

- **`ThemeController` (ChangeNotifier)** loads the persisted theme on startup and writes to `SharedPreferences` on every toggle, so the selected theme survives a full app kill and relaunch.
- **`StorageService`** centralizes all `SharedPreferences` reads/writes — total attempts, highest score, last score, and a JSON-encoded list of the last 10 `QuizResult` objects (trimmed and reordered newest-first on every write).
- **GoRouter** drives navigation declaratively: `/` → `/quiz/:categoryId` → `/result`, with the result screen receiving quiz outcome data via route `extra`, and using `pushReplacement` so users can't navigate back into a finished quiz.
- **No backend/API** — all questions and results are handled entirely on-device, per the assignment requirement.

## 📸 Screens

| Home | Quiz | Result |
|---|---|---|
| Dashboard with stats, categories & history | Dynamic MCQ flow with progress bar | Score summary with Play Again / Back to Home |

## 📄 License

This project was built for educational purposes as part of a Flutter development assignment.
