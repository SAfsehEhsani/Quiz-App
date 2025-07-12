# 🧠 Flutter Quiz App

A simple and elegant quiz app built using **Flutter** that fetches trivia questions from an API and stores user scores locally using SQLite.

# APK Link : https://drive.google.com/file/d/17S2yXUljz909cwfzJnu4wnI5_TQoFuNg/view?usp=sharing


![Quiz App Screenshot](assets/screenshot/Home.jpg)

---

## ✨ Features

- 🧾 Fetches 5 random quiz questions from [Open Trivia DB](https://opentdb.com)
- ✅ Multiple choice answers with real-time feedback
- 📊 Score saved locally using SQLite
- 📋 Score history screen
- 🎨 Beautiful, responsive UI with custom icon

---

## 🚀 Screens

| Quiz Home Screen        | Questions UI          | Score History |
|-------------------------|------------------------|----------------|
| ![Home](assets/screenshot/Home.jpg) | (assets/screenshot/Questions.jpg) | (assets/screenshot/Score.jpg) |

---

## 🛠 Tech Stack

- **Flutter** 🐦
- `http` for API calls
- `sqflite` + `path_provider` for local database
- `flutter_launcher_icons` for app icon

---

## 📦 Installation

### Prerequisites:
- Flutter SDK installed
- Android Studio or VS Code with Flutter extensions

### Steps:

```bash
git clone https://github.com/your-username/quiz_app.git
cd quiz_app
flutter pub get
flutter run

