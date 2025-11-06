# 🎮 Game Stream

GameStream is an iOS application built with **SwiftUI**, developed as a learning project inspired by a **Platzi course**, but later refactored, reorganized, and extended by **David Santiago Girón Muñoz**.  
The app allows users to browse and view information about different video games, including images, videos, and detailed descriptions — all fetched from a public API.

It also includes a **local login and profile management system**, where users can **take or upload a profile picture** and store their information locally using **UserDefaults**.

---

## ✨ Features

- Browse a collection of 8 video games. 
- Local login and user profile with photo support.  
- Data persistence through `UserDefaults`.  
- View each game's **image gallery**, **trailer video**, and **description**  
- Built entirely with **SwiftUI**  
- Uses **async/await** for networking  
- Clean and organized **MVVM pattern**  
- Designed following a Figma prototype  

---

## 🧠 Tech Stack

| Category | Tools / Technologies |
|-----------|----------------------|
| Language | Swift 6 |
| Framework | SwiftUI |
| Architecture | MVVM |
| IDE | Xcode 26 |
| Target Platform | iOS 26 |
| Networking | URLSession + async/await |
| Design | Figma |

---

## 🌐 API Reference

Data is fetched from the [GameStream API](https://gamestreamapi.herokuapp.com/api-docs/#/default), which provides information, images, and videos for various games through two endpoints.

---

## 🎨 App Design (Figma)

The UI is inspired by this **Figma prototype:**  
🎨 [View Design on Figma](https://www.figma.com/design/J62PMUCv8uCtKNpoN3L7iK/Game-Stream?node-id=21-22)

---

## 🗂️ Project Structure

```plaintext
GameStream/
├── Assets.xcassets/       # App icons, colors, and image assets
├── Model/                 # Data models representing entities
├── Utils/                 # Helper functions
├── View/                  # SwiftUI views that define the app's UI
│   ├── Auth/              # Screens for login or authentication flow
│   ├── Games/             # Game list and detail views
│   ├── Home/              # Main home screen and navigation
│   ├── Profile/           # User profile interface
│   ├── Shared/            # Reusable SwiftUI components
│   ├── FavoritesView.swift   # Screen displaying user's favorite games
│   ├── TemporalView.swift    # Temporary view
└── ViewModel/             # Logic and data management
```

Each folder corresponds to a logical layer of the **MVVM architecture**, keeping the project modular and easy to maintain.

---

## 🚀 Purpose

GameStream was created as a **personal learning project**, exploring:

- Integration of external APIs with SwiftUI  
- UI composition using SwiftUI Views  
- Managing data and state with MVVM
- Data persistence with UserDefaults.
- Modular organization and reusable views.
- Basic camera and photo handling in iOS.

---

## 👤 Author

**David Santiago Girón Muñoz**

- 🐙 GitHub: [DSantiagG](https://github.com/DSantiagG)  
- 🐦 X (Twitter): [@DSantiagG](https://x.com/DSantiagG)  
- 💼 LinkedIn: [Santiago Girón Muñoz](https://www.linkedin.com/in/dsantiagg/)


