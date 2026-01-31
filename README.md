# COOK'd (The App)

A simple and beautiful recipe app built with Flutter using TheMealDB API.

## Features

**Search Recipes** - Find meals by name  
**Random Recipe** - Discover something new  
**Recipe Details** - View ingredients and instructions  
**Beautiful Design** - Orange and cream color theme with custom fonts

## Screenshots

- Home screen with search bar
- Recipe cards with images
- Detailed recipe view with ingredients and instructions

## Setup

1. **Install Flutter** (if you haven't already)
    - Visit: https://flutter.dev/docs/get-started/install

2. **Clone or download this project**
   ```cmd
   git clone
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Tech Stack

- **Flutter** - UI framework
- **TheMealDB API** - Recipe data
- **Google Fonts** - Pacifico & Poppins fonts
- **HTTP** - API requests

## Color Scheme

- Primary: Orange `#FF8C42`
- Secondary: Cream `#FFF4E6`

## API

This app uses the free api [TheMealDB API](https://www.themealdb.com/)

## Project Structure

```
lib/
├── main.dart                    # Contains main entry and theme of the app
├── model/
│   └── meal.dart               # Recipe data model
├── repository/
│   └── meal_repository.dart    # For API calls
└── screens/
    ├── home_screen.dart        # Search & list
    └── meal_detail_screen.dart # Recipe details
```

## How to Use

1. **Search** - Type a recipe name and tap Search
2. **Random** - Tap the floating button for a random recipe
3. **Details** - Tap any recipe card to view full details

## Requirements

- Flutter SDK 3.0.0 or higher
- Android Studio / VS Code
- Android Emulator or iOS Simulator

---
