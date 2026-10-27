# 💰 Money Tracker

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue?style=for-the-badge&logo=flutter" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart" alt="Language">
  <img src="https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Framework">
  <img src="https://img.shields.io/badge/State-Riverpod-purple?style=for-the-badge" alt="State Management">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen?style=for-the-badge" alt="Architecture">
  <img src="https://img.shields.io/badge/Security-PIN%20%26%20Biometrics-critical?style=for-the-badge" alt="Security">
  <img src="https://img.shields.io/badge/Mode-Dark%20%26%20Light-yellow?style=for-the-badge&logo=flutter" alt="Theme Mode">
</div>

<div align="center">

### Start mastering your finances today
*The smart way to track every penny, visualize your spending and achieve your financial goals.*

</div>

---

## 📱 About the Project

**Money Tracker** is your personal financial companion, designed to help you master your money management.  
From tracking daily income and expenses to keeping an eye on your overall balance, discover the power of financial awareness and make smarter decisions with every transaction.

The project is being built as a deliberate, professional-grade learning exercise: a small, functional app evolving step by step on top of a **Feature-First + Clean Architecture** foundation, so new capabilities can be added without compromising maintainability or testability.

### ✨ What Makes Money Tracker Special?

- 💳 **Complete Transaction Management** – Add and delete income and expense entries, with real-time balance updates
- 📅 **Smart Date Grouping** – Transactions are grouped into "Today", "Yesterday", and short weekday/date sections, just like leading finance apps
- 📊 **At-a-Glance Overview** – Animated balance, income and expense summary cards on the home screen
- 🌓 **Real Adaptive Theming** – Light/Dark/System mode, persisted and applied instantly across the whole app
- 🌍 **Real Multi-Language & Multi-Currency** – Spanish, English, French, German and Polish; USD, EUR, GBP and PLN, with live currency-correct input and formatting throughout
- 🔐 **PIN & Biometric Security** – App-open lock screen, PIN code (salted-hash, securely stored) and biometric authentication (Face ID / Touch ID / fingerprint), with biometric-first verification and PIN fallback for sensitive actions
- 🔗 **Connected About Screen** – Real links to the developer's LinkedIn, GitHub and email
- 📱 **Cross-Platform** – A single Dart codebase producing a native experience on both iOS and Android, with a native splash screen

---
## 📸 Screenshots

<div align="center">

| <img src="https://github.com/user-attachments/assets/34558867-0768-4e5e-8c39-d78ae72491bb" width="250" alt="Main Dashboard"> | <img src="https://github.com/user-attachments/assets/44e2b34b-9b82-4e93-9af9-aa48e4722c4a" width="250" alt="New Income"> | <img src="https://github.com/user-attachments/assets/b6ef9ae3-46e4-42e4-baac-b54122126955" width="250" alt="Settings"> |
|:---:|:---:|:---:|
| **Main Dashboard** | **New Income** | **Settings** |


<br>

| <img src="https://github.com/user-attachments/assets/ab5590aa-76a4-435f-bb37-0005b126b411" width="250" alt="PIN Security"> | <img src="https://github.com/user-attachments/assets/df04d931-9736-4ff6-b7c2-1299b8976091" width="250" alt="Fingerprint protection"> | <img src="https://github.com/user-attachments/assets/f7b54d03-df90-4e6d-9363-db743b38a93c" width="250" alt="Dark theme"> |
|:---:|:---:|:---:|
| **PIN Security** | **Fingerprint protection** | **Dark theme** |

</div>

<br>

> ℹ️ These images are from the portfolio app associated with this repository. They may differ from the final complete version currently published on the Google Play Store.

---

## 🛠️ Tech Stack

### 🏗️ **Framework & Architecture**
- **Flutter** – Cross-platform framework for native iOS & Android apps
- **Dart** – Fast, modern programming language optimized for UI
- **Feature-First + Clean Architecture (lightweight)** – Code organized by feature, with clear `domain` / `data` / `presentation` layers, keeping business logic decoupled from UI and persistence

### 💉 **State Management**
- **Riverpod** (`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`) – Reactive, code-generated state management, using `AsyncNotifier` to handle loading/data/error states automatically

### 🧬 **Domain Modeling**
- **Freezed** – Immutable domain entities (e.g. `Transaction`) with generated `copyWith`, value equality and more
- **Dart enhanced enums** – Type-safe options (`ThemeModeOption`, `LocaleOption`, `CurrencyOption`) with built-in conversion logic, replacing raw strings
- **build_runner** – Code generation engine powering Riverpod and Freezed

### 💾 **Data & Preferences Persistence**
- **SQLite** (via `sqflite`) – Centralized local relational database (`AppDatabase`), shared across features
- **Repository Pattern** – `TransactionsRepository` abstracts persistence behind an interface, so the data source can be swapped without touching business logic or UI
- **shared_preferences** – Simple key-value storage for non-sensitive user settings (theme, language, currency, biometric toggle)

### 🔐 **Security**
- **`flutter_secure_storage`** – PIN storage backed by iOS Keychain / Android Keystore
- **`crypto`** – PIN is never stored in plain text; only a salted SHA-256 hash is persisted
- **`local_auth`** – Biometric authentication (Face ID, Touch ID, fingerprint), device capability–aware
- Custom **PIN entry / biometric prompt screens** with animated feedback (shake, haptics, success states), reused across setup, verification, and app-unlock flows

### 🧭 **Navigation**
- **GoRouter** – Declarative, nested routing, replacing manual `Navigator` calls for full-screen navigation
- App-lock overlay integrated at the `MaterialApp` level, gating the entire app behind PIN/biometric verification on cold start

### 🎨 **User Interface & Theming**
- **Material Design 3** – Clean, modern design language
- **Centralized Design System** (`AppColors` / `AppTheme`) – A single source of truth for brand and semantic colors, generating both light and dark `ThemeData`, with real-time switching driven by user preference
- **country_flags** – Vector flag icons for the language and currency selectors
- **Custom animations** – Entrance transitions, cascading list animations, and micro-interactions throughout the UI
- **`flutter_native_splash`** – Native splash screen on both platforms

### 💱 **Formatting**
- **`CurrencyFormatter`** – Locale-aware currency formatting; whole amounts omit trailing decimals (`5.00 → 5`) for a cleaner look, with a dedicated, always-2-decimal variant for live text input
- **`RelativeDateFormatter`** – Pure, unit-testable date-to-label logic ("Today", "Yesterday", "Mon, Mar 8", "Mon, Mar 8, 2025")

### 🔗 **External Integrations**
- **`url_launcher`** – Opens the developer's LinkedIn, GitHub, and email from the About screen, with graceful error handling

### 🌍 **Internationalization**
- **Flutter Intl (`.arb` files)** – Full translations for Spanish, English, French, German and Polish across the entire app UI

---

## 🗺️ Project Structure

Money Tracker follows a **Feature-First + Clean Architecture** approach: code is organized by feature first, and each feature is internally split into `domain` (entities, repository contracts), `data` (repository implementations, data sources) and `presentation` (screens, widgets, Riverpod providers) layers. Cross-cutting concerns (theming, persistence, security, formatting) live in `core/`, and UI shared by more than one feature lives in `shared/`.

```plaintext
📦 lib/
 ┣ 📂 core/
 ┃ ┣ 📂 currency/          # CurrencyOption, CurrencyFormatter, CurrencyNotifier, input formatter
 ┃ ┣ 📂 database/          # Centralized AppDatabase (SQLite)
 ┃ ┣ 📂 formatting/        # RelativeDateFormatter
 ┃ ┣ 📂 locale/            # LocaleOption, LocaleNotifier
 ┃ ┣ 📂 router/            # app_router.dart (GoRouter)
 ┃ ┣ 📂 security/          # PIN + biometric services, notifiers, SecurityGate, lock screens
 ┃ ┣ 📂 services/          # PreferencesService, ExternalLinkLauncher
 ┃ ┗ 📂 theme/             # AppColors, AppTheme, ThemeModeOption, ThemeNotifier
 ┣ 📂 features/
 ┃ ┣ 📂 transactions/
 ┃ ┃ ┣ 📂 data/            # Datasources & repository implementation
 ┃ ┃ ┣ 📂 domain/          # Transaction entity & repository contract
 ┃ ┃ ┗ 📂 presentation/    # Screens, widgets, providers, date-grouping utils
 ┃ ┗ 📂 settings/
 ┃   ┗ 📂 presentation/    # Settings & About screens and widgets
 ┣ 📂 shared/
 ┃ ┗ 📂 presentation/widgets/  # CustomDialog, ConfirmationDialog, AppSnackbar
 ┣ 📂 l10n/                # .arb files (en, es, fr, de, pl) + generated localizations
 ┗ 🚀 main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9 or higher)
- Dart SDK (3.9 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator (physical device recommended for testing biometric authentication)

### Installation

```bash
# Clone the repository
git clone https://github.com/sergiosabater/moneytracker-portfolio.git

# Navigate to project directory
cd moneytracker-portfolio

# Install dependencies
flutter pub get

# Generate code (Riverpod providers & Freezed entities)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## 💡 Usage Guide

1. **🎯 Create Your First Transaction**  
   Tap the **"+"** button on the home screen to add an income or expense entry

2. **📊 Check Your Overview**  
   The animated header shows your current balance, total income and total expenses at a glance

3. **📅 Browse Grouped History**  
   Transactions are grouped by date — "Today", "Yesterday", and short date labels for older entries

4. **🗑️ Manage Transactions**  
   Long-press any transaction to edit (coming soon) or delete it

5. **⚙️ Personalize the App**  
   Tap the settings icon to switch theme (Light/Dark/System), language, and currency — all applied instantly and remembered next time you open the app

6. **🔐 Secure Your Data**  
   Enable a PIN code (and, once a PIN is set, biometric authentication) to lock the app on open and protect destructive actions like clearing all data

7. **👤 Learn More**  
   From Settings, tap **About** to see what the app does and a short profile of the developer, with working links to LinkedIn, GitHub, and email

---

## 📝 Roadmap

### 🎯 Upcoming Features

- 🏷️ **Transaction Categories** – Categorize income and expenses, reflected directly on each transaction card
- 🔍 **Date Filters** – Filter transaction history by custom date ranges, building on the existing date-grouping logic
- 📊 **Visual Analytics** – Charts and graphs to understand spending patterns over time
- 🎯 **Budget Control** – Monthly budgets with real-time tracking
- ✏️ **Edit Transactions** – Currently add/delete only; editing is scaffolded in the UI but not yet implemented
- 📸 **Receipt Scanner** – Capture and store receipts with OCR technology
- 🌐 **Cloud Sync** – Access your data across multiple devices
- 📅 **Financial Goals** – Set and track long-term savings objectives
- 🔔 **Smart Notifications** – Bill reminders and budget alerts
- 🧪 **Unit Test Coverage** – Expanding automated tests across formatters, notifiers, and repositories

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📧 Contact

For questions, suggestions, or collaboration opportunities:

**Email:** sergiosabater@gmail.com  
**LinkedIn:** [Sergio Sabater Muñoz](https://www.linkedin.com/in/sergio-sm/)

---

<div align="center">

###  Start mastering your finances today

**⭐ If this project helps you manage your money better, give it a star! ⭐**

</div>

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Made with 💙 by <strong>Sergio Sabater</strong>
</div>
