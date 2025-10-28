# 🎬 Movie Catalog App

**Platform:** iOS 13+  
**Architecture:** MVVM  
**UI Frameworks:** UIKit (Storyboard / XIB) + SwiftUI  
**External Library:** 
[SDWebImage](https://github.com/SDWebImage/SDWebImage),
[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)

**Data Source:** [TMDB API](https://developer.themoviedb.org/)

---

## 📱 Overview

This project is an iOS application that displays a list of top-rated movies using **The Movie Database (TMDB)** public API.  
The app is built using **UIKit** as the main UI framework, with at least one screen (Movie Details) implemented in **SwiftUI** and integrated via `UIHostingController`.

---

## 🧩 Features

### 1. Movie Catalog (Top Rated)
- Fetches data from TMDB **Top Rated** endpoint.  
- Displays:
  - Movie poster  
  - Title  
  - Average rating  
  - Favorite status (stored locally)
- Layout:
  - Two-column grid presentation  
- Includes:
  - **Pull-to-refresh**  
  - **Pagination** (loads 2 pages concurrently)  
  - **Central loader** shown during initial data fetch  
- **Navigation bar** shows the **average rating** of all loaded movies.  

### 2. Movie Details Screen
- Receives a **movie ID** from the catalog list.  
- Fetches and displays detailed information:
  - Poster  
  - Title  
  - Average rating  
  - Description  
  - Release date  
- Implemented using **SwiftUI** for a modern declarative approach.  

---

## 🧠 Architecture

The app follows the **MVVM (Model–View–ViewModel)** pattern:
- **Model:** Represents movie data and API responses.  
- **ViewModel:** Handles API calls, pagination logic, and state management.  
- **View (UIKit / SwiftUI):** Displays data and user interactions.  

---

## ⚙️ Technologies Used

- **UIKit** – for the main interface (Storyboard / XIB)
- **SwiftUI** – for the Movie Details screen  
- **SDWebImage** – for async image loading and caching  
- **TMDB API** – public movie database for data fetching  

---

## 🧾 Requirements

- iOS 13 or higher  
- Xcode 15+  
- Swift 5.9+  
- Active TMDB API key  

---

## 🧭 Future Improvements

- Search and filter movies by genre  
- Offline cache support  
- Enhanced UI animations
- Custom FlowLayout for smooth scroling  
- Dark mode optimization
- Favorites
