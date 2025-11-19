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
5.  **Persistency (UserDefaults):** Custom implementation in `FortuneProvider` to save and load favorites permanently.
6.  **Optionals & Safe Unwrapping:** Extensive use of `if let` and `guard` to prevent crashes.
7.  **Auto Layout:** Adaptive constraints to ensure the UI works on different iPhone sizes.
8.  **Animations:** Usage of `UIView.animate` (spring animations) for display effects.
9.  **Enums & State Management:** A `CookieState` enum controls the game flow (Whole -> Cracked -> Broken -> Revealed).
10. **Structs (Value Types):** The data model uses `Struct` for efficiency and thread safety.

## ✨ Advanced Implementation Details (New Concepts)
This section explains concepts that required external learning or advanced implementation to fulfill the project's requirements, including necessary citations.

### 1. Data Persistence: Codable, JSONEncoder/Decoder
* **Concept/Reference:** `Codable` protocol and JSON serialization/deserialization with `UserDefaults`.
* **External Source (Title/Author/URL):** "UserDefaults with Codable in Swift" by **Ahmed Adam**.
* **URL:** `https://ahmedahmedadam.medium.com/userdefaults-with-codable-in-swift-aadc787695a6`.
* **What was learned:** Learned to implement the **`Codable`** protocol on the custom `Fortune` struct and to utilize **`JSONEncoder`** and **`JSONDecoder`** to serialize Swift objects into the `Data` type for persistence.
* **Why it was necessary:** This approach was essential for saving the array of custom `Fortune` objects (`[Fortune]`) permanently in `UserDefaults`, as it does not natively support custom structs, ensuring the favorites collection persists across app launches.

### 2. Advanced UX: Core Animation (`CAKeyframeAnimation`) and Haptics (`UIImpactFeedbackGenerator`)
* **Concept/Reference 1 (Animation):** `CAKeyframeAnimation` (Core Animation).
* **External Source 1 (Title/Author/URL):** "Keyframe Animations in iOS Development" by **Adi Mizrahi**.
* **URL:** `https://medium.com/codex/unlocking-the-power-of-keyframe-animations-in-ios-development-3140c93ddea3`.
* **Concept/Reference 2 (Haptics):** `UIImpactFeedbackGenerator`.
* **External Source 2 (Title/Author/URL):** "How to Play Haptic Feedback or Vibrate using UIFeedbackGenerator" by **Sarun W.**.
* **URL:** `https://sarunw.com/posts/play-haptic-feedback-using-uifeedbackgenerator/`.
* **What was learned:** Utilized **`CAKeyframeAnimation`** to create a complex, non-linear "shake" effect on the cookie button by specifying keyframe values. Implemented **`UIImpactFeedbackGenerator`** to provide specific tactile feedback for the cracking and breaking stages.
* **Why it was necessary:** Standard `UIView.animate` was insufficient to achieve the realistic and responsive "game feel" required for the interactive multi-stage cookie cracking sequence.

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

## 🔗 GitHub (Proof of Repository)
`https://github.com/fernandobulnesga/FortuneCookieWisdom`
