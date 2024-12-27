# Sparks Systems Flutter App

This is a fully functional Flutter app designed to display various metrics, including orders, sales, and returns, with the help of dynamic charts. It utilizes the Flutter BLoC pattern for state management and includes localization support for multiple languages.

## Features

- Line charts to display order data.
- Metrics to track total sales, orders, and returns.
- Language switch between English and another language (handled via BLoC).
- Fetch data from a repository and display it on the app.

## Deliverables

1. A fully functional Flutter app.
2. A GitHub repository with:
   - The source code of the app.
   - A `README.md` file (this file) with setup instructions.
   - Any assumptions made during development.
3. Optional: Unit tests for critical parts of the application.

## Setup and Running the App

### Prerequisites

Ensure you have the following installed on your machine:

- Flutter SDK (https://flutter.dev/docs/get-started/install)
- Dart SDK (if not included with Flutter)
- Android Studio, Xcode (for iOS) or any other IDE you prefer (e.g., VS Code).

### Steps to Run the App

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/sparks_systems_app.git

   ```

2. Navigate to the project directory:
   cd sparks_systems_app

3. Install the dependencies:
   flutter pub get

4. Run the app on an emulator or connected device:
   flutter run

### Assumptions

1. Data Handling: Data is fetched via a DataRepository class, which loads JSON data representing orders from a remote source or local files. The data is then processed and displayed using charts and statistics widgets.

2. Language Support: The app supports multiple languages, with the ability to switch between them using a Switch widget in the app's AppBar. The default language is English, and additional languages are supported via the flutter_localizations package.

3. Metrics Calculation: The app calculates various metrics, such as total sales (Only for ordered or delivered orders), order returns, and monthly order counts (For all order types), in the GraphCubit. These calculations are based on the fetched order data.
