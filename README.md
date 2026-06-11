# Ditonton 🎬

[![Codemagic build status](https://api.codemagic.io/apps/6a2a3d5b270053c6778f5044/6a2a3d5b270053c6778f5043/status_badge.svg)](https://codemagic.io/app/6a2a3d5b270053c6778f5044/6a2a3d5b270053c6778f5043/latest_build)

A Flutter-based movie and TV series catalog app powered by the [The Movie Database (TMDB) API](https://www.themoviedb.org/). Built as the final submission for the **Flutter Expert Class — Dicoding Indonesia**.

---

## ✨ Features

- 🎬 **Movies**: Browse Now Playing, Popular, and Top Rated movies
- 📺 **TV Series**: Browse On The Air, Popular, and Top Rated TV series
- 🔍 **Search**: Search for movies and TV series in real-time
- 📋 **Watchlist**: Save favorite movies and TV series locally (SQLite)
- 🗓️ **Season & Episode**: View detailed season and episode information for TV series

---

## 🏗️ Architecture

This app follows **Clean Architecture** with three layers:
- **Domain**: Entities, Use Cases, Repository interfaces
- **Data**: Models, Data Sources (Remote & Local), Repository implementations
- **Presentation**: BLoC (state management), Pages, Widgets

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter 3.44.0 | UI Framework |
| BLoC | State Management |
| GetIt | Dependency Injection |
| SQLite (sqflite) | Local Storage |
| TMDB API | Data Source |
| SSL Pinning | Network Security |
| Firebase Analytics | User Analytics |
| Firebase Crashlytics | Crash Reporting |
| GitHub Actions | CI/CD |

---

## 🚀 Getting Started

```bash
# Clone the repository
git clone https://github.com/denidoodle12/Ditonton.git

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🧪 Running Tests

```bash
# Run all unit tests
flutter test

# Run with coverage report
flutter test --coverage
```

---

## 📋 Tips for Final Submission

If you apply modularization to the project, you can use the `test.sh` file in this repository to simplify the testing process via *terminal* or *command prompt*. Before running it, follow these steps:

1. Install the required tools based on your Operating System (OS).
    - For **Linux** users, run the following command in the terminal:
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```
    - For **Mac** users, run the following command in the terminal:
        ```
        brew install lcov
        ```
    - For **Windows** users, follow these steps:
        - Install [Chocolatey](https://chocolatey.org/install) on your machine.
        - Then, install [lcov](https://community.chocolatey.org/packages/lcov) by running:
            ```
            choco install lcov
            ```
        - Check the **Environment Variables** under **System variables** for GENTHTML and LCOV_HOME. If not present, add new variables with the following values:

            | Variable | Value |
            | ----------- | ----------- |
            | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
            | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

2. To simplify the testing verification process, run:
    ```
    git init
    ```
3. Then run the `test.sh` file using the following command in *terminal* or *PowerShell*:
    ```
    test.sh
    ```
    or
    ```
    ./test.sh
    ```
    This will generate the `lcov.info` file and a `coverage` folder containing the coverage report.
4. Wait for the testing process to complete until the coverage report web page appears.
