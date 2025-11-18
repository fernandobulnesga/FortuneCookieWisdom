# Fortune Cookie Wisdom 🥠

**Project Title:** Fortune Cookie Wisdom
**Group Member:** Fernando Bulnes Garrorena (Lead Developer)
**Course:** iOS Application Development

---

## 📱 App Purpose
Fortune Cookie Wisdom is an interactive iOS application designed to provide daily motivation through a gamified experience. Users crack open a virtual fortune cookie using touch gestures and animations to reveal wisdom quotes, which can be collected and managed in a personal favorites list.

## 🛠 Implemented Course Concepts (10+)
This project demonstrates the following concepts learned in class:

1.  **MVC Architecture:** Strict separation of Models (Fortune), Views (Storyboards), and Controllers.
2.  **TableView & Data Source:** Implementation of `UITableViewDataSource` to display the favorites collection.
3.  **Delegation Pattern:** Used `UITableViewDelegate` for row deletion and interaction handling.
4.  **Navigation Controller:** Hierarchical navigation between the main game screen and the history screen.
5.  **Persistency (UserDefaults):** Custom implementation in `FortuneProvider` to save and load favorites permanently using `Codable`.
6.  **Optionals & Safe Unwrapping:** Extensive use of `if let` and `guard` to prevent crashes.
7.  **Auto Layout:** Adaptive constraints to ensure the UI works on different iPhone sizes.
8.  **Animations:** Usage of `UIView.animate` (spring animations) and `CATransaction` for the cookie shaking effect.
9.  **Enums & State Management:** A `CookieState` enum controls the game flow (Whole -> Cracked -> Broken -> Revealed).
10. **Structs (Value Types):** The data model uses `Struct` for efficiency and thread safety.

## 🚀 Setup Instructions
1.  Open `FortuneCookieWisdom.xcodeproj` in Xcode (Version 15+ recommended).
2.  Select an iPhone Simulator (e.g., iPhone 16 Pro).
3.  Press **Cmd + R** to build and run.
4.  **Usage:**
    * Tap the cookie 3 times to crack the shell.
    * Tap 3 more times to break it open.
    * Tap once more to reveal your fortune.
    * Tap the ❤️ icon to save it to your collection.
    * Tap the Book icon (top-right) to view your saved wisdom.

## 🔗 GitHub
https://github.com/fernandobulnesga/FortuneCookieWisdom
