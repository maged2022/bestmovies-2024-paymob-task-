# 🎬 BestMovies App

**BestMovies** is an iOS application that displays a list of top 2024 movies fetched from [TheMovieDB API](https://www.themoviedb.org/). The app is built using `UIKit`, following the `MVVM` + `Clean Architecture` pattern, and leverages modern iOS technologies such as `Combine`, `Core Data`, and `Coordinator pattern`.

---

## 📦 Features

### 🔹 `feature/movie-list-ui`
- A fully designed movie list screen using Storyboard (not programmatically).
- Displays movie posters, titles, ratings, release dates and favorites option.
- Utilizes reusable `UITableViewCell` with proper constraints and layout.
- Pull-to-refresh support.

---

### 🔹 `feature/movie-details-screen`
- Detailed screen showing:
  - Poster
  - Title
  - Rating
  - Release Date
  - Overview
  - Original Language
- Favorite button to toggle movie’s favorite status.
- Navigation implemented using `Coordinator Pattern`.

---

### 🔹 `feature/fetch-movies-from-api`
- Fetches 2024 trending movies using [TheMovieDB API].
- API service built with `URLSession` and `Combine`.
- Proper error handling, decoding, and mapping to domain models.
- MVVM integration with `ObservableObject` style binding using Combine.

---

### 🔹 `feature/refactor-mvvm-clean-architecture`
- Implements Clean Architecture with clear separation of concerns:
  - **Presentation Layer:** ViewControllers + ViewModels
  - **Domain Layer:** UseCases + Entities + Interfaces ( Protocols )
  - **Data Layer:** API Clients, Repositories, Core Data stack
- Scalable, testable, and maintainable codebase.

---

### 🔹 `feature/caching-image-kingfisher`
- Uses **Kingfisher** library to load and cache images efficiently.
- Improves performance and UX by avoiding redundant network calls.
- Graceful handling of missing or broken image URLs.

---

### 🔹 `feature/save-favorite-movies-coredata`
- Users can mark/unmark movies as favorite.
- Favorite movies are stored locally using **Core Data**.
- Persistent storage with unique `movieId` key.
- Supports offline access to favorite list.

---

### 🔹 `feature/use-coordinator-pattern`
- Navigation is decoupled from ViewControllers using `Coordinator Pattern`.
- Centralized flow management for better scalability and testability.
- Coordinators handle push/pop transitions and passing data between screens.

---

## 📱 Technologies Used

- UIKit + Storyboard
- MVVM + Clean Architecture
- Combine
- Core Data
- Kingfisher (Image caching)
- Coordinator Pattern
- URLSession.DataTaskPublisher + Combine + EndPoints (for networking)

---

## 📸 Screenshots

> *(Add your UI screenshots here to visually show the app)*

---

## 🧪 Future Improvements

- Unit tests for ViewModels and UseCases.
- Add search functionality.
- Support for dark mode.
- Localization for multiple languages.

---

## ✨ Author

**Maged Mohammed**  
iOS Developer | Swift | UIKit & SwiftUI  
https://www.linkedin.com/in/maged-mohammed-5812b821b/

---

