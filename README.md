# 📈 StockTracker

A clean, minimalist iOS app for tracking stocks, featuring favorites, theme selection, and live updates — all built using modern SwiftUI patterns.


---
</br></br>

## 🚀 Features

- 🔖 **Favorite Stocks** — Tap to favorite stocks and view them in a separate tab
- 🔃 **Live Updates** — Polls for updated data every 30 seconds (toggleable)
- 🔢 **Sort Options** — Sort favorites by ascending or descending ticker
- 🎨 **Theme Control** — Choose Light, Dark, or System theme via Settings
- 🧑‍🦯 **Accessibility Support** — VoiceOver, Dynamic Type, and color contrast ready
- 🧱 **Modular Components** — Includes reusable buttons and row components (`FavoriteStarButton` and `SortOrderButton`)
- 🧪 **Unit + UI Tests** — Test coverage for data fetching, state updates, and UI flow

---

</br>

## 🏗 Architecture & Design

### 🧱 MVVM Structure
- **Model**: `Stock` struct represents stock data
- **ViewModel**: `StockViewModel` handles data loading, business logic, and favorite state.
- **View**: SwiftUI-based screens (`StockListView`, `FavoriteListView`, `SettingsView`)

### Reactive UI
- SwiftUI's `@Published`, `@StateObject`, and `@AppStorage` keep views in sync with user preferences and model state.

### 🔄 Data Loading
- Stocks loaded from bundled JSON via `StockService`
- `StockServiceProtocol` allows injection of mock/failing services for testing

### 💾 Persistence
- Favorites saved via `UserDefaults` (`Core Data` to be implemented in the future)
- User preferences (theme, live updates) stored via `@AppStorage`

### 🧪 Testing
- `MockStockService`, `BadJSONStockService`, and `TestStockService` support unit testing through Dependency Injection.
- UI tests target identifiable elements (e.g. `star-META`) using `accessibilityIdentifier`

---

</br>

### 📁 Project Structure

- 📂 StockTracker
- ├─ 📁 Models             → Stock.swift
- ├─ 📁 ViewModels         → StockViewModel.swift
- ├─ 📁 Views              → StockListView.swift, FavoriteListView.swift, SettingsView.swift
- ├─ 📁 Components         → FavoriteStarButton.swift, SortOrderButton.swift, SectionLabel.swift
- ├─ 📁 Services           → StockService.swift
- ├─ 📁 Resources          → example_response.json
- ├─ 📁 Helpers            → Color+AppStyle.swift, View+MinimalStyle.swift
- ├─ 📁 Tests              → Unit and UI Tests


---

</br>

## ⚙️ Setup Instructions

1. Clone the repo  
   ```bash
   git clone https://github.com/yourusername/stocktracker.git
   cd stocktracker
2. Open in Xcode
    ```bash
   open StockTracker.xcodeproj
3. Run on iOS 16+ Simulator or device

</br>

##  ✅ Requirements
  - iOS 16.0+
  - Swift 5.9+
  - Xcode 15+

</br>

## 🧪 Running Tests
  Run all tests using the Test navigator or from the terminal:
  ```bash
  xcodebuild test -scheme StockTracker -destination 'platform=iOS Simulator,name=iPhone 15'
```

Tests include:
- ✅ StockServiceTests
- ✅ StockViewModelTests
- ✅ UI tests for favorites and tabs

---

</br></br>

## 🚀 Next Steps (optional)

- WebSocket integration for true real-time updates
- Core Data or CloudKit sync for favorites
- Localizable strings for multilingual support
- More advanced filtering (e.g. by sector or price range)
