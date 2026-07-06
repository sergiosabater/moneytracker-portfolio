# 💰 Money Tracker

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue?style=for-the-badge&logo=flutter" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart" alt="Language">
  <img src="https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Framework">
  <img src="https://img.shields.io/badge/State-Riverpod-purple?style=for-the-badge" alt="State Management">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen?style=for-the-badge" alt="Architecture">
  <img src="https://img.shields.io/badge/Mode-Dark%20%26%20Light-yellow?style=for-the-badge&logo=flutter" alt="Theme Mode">
</div>

<div align="center">

### Take Control of Your Financial Future!
*The smart way to track every penny, visualize your spending, and achieve your financial goals.*

</div>

---

## 📱 About the Project

**Money Tracker** is your personal financial companion, designed to help you master your money management.  
From tracking daily income and expenses to keeping an eye on your overall balance, discover the power of financial awareness and make smarter decisions with every transaction.

The project is being built as a deliberate, professional-grade learning exercise: a small, functional app evolving step by step on top of a **Feature-First + Clean Architecture** foundation, so new capabilities can be added without compromising maintainability or testability.

### ✨ What Makes Money Tracker Special?

- 💳 **Complete Transaction Management** – Add and delete income and expense entries, with real-time balance updates
- 📊 **At-a-Glance Overview** – Animated balance, income and expense summary cards on the home screen
- 🌓 **Adaptive Theming Foundation** – Centralized light/dark color system, automatically following the OS-level appearance setting
- 🌍 **Multi-Language & Multi-Currency Selectors** – Settings screen ready for Spanish, English, French, German and Polish, and for USD, EUR, GBP and PLN
- 🔐 **Security Section (UI ready)** – PIN code and biometric authentication entries prepared in Settings, pending real implementation
- 📱 **Cross-Platform** – A single Dart codebase producing a native experience on both iOS and Android

---
## 📸 Screenshots

<div align="center">

| <img src="https://github.com/user-attachments/assets/09b869ef-aaeb-47c9-abe8-4d7b763a6ea2" width="250" alt="Main Dashboard"> | <img src="https://github.com/user-attachments/assets/f568e549-521f-4ac3-9792-6f7e2d2b278f" width="250" alt="New Income"> | <img src="https://github.com/user-attachments/assets/8aecec89-f4c8-4d6c-b971-38db4fba84f5" width="250" alt="New Expense"> |
|:---:|:---:|:---:|
| **Main Dashboard** | **New Income** | **New Expense** |

<br>

| <img src="https://github.com/user-attachments/assets/16b2bbbd-e45f-4b68-8a16-c34e6af7c993" width="250" alt="Missing Description Alert"> | <img src="https://github.com/user-attachments/assets/62d1a894-7ecf-4009-b3d7-4484dd0cc3de" width="250" alt="Delete Transaction Alert"> | <img src="https://github.com/user-attachments/assets/09b869ef-aaeb-47c9-abe8-4d7b763a6ea2" width="250" alt="Main Dashboard"> |
|:---:|:---:|:---:|
| **Missing Description Alert** | **Delete Transaction Alert** | **Main Dashboard** |

</div>

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
- **build_runner** – Code generation engine powering Riverpod and Freezed

### 💾 **Data Persistence**
- **SQLite** (via `sqflite`) – Local relational database
- **Repository Pattern** – `TransactionsRepository` abstracts persistence behind an interface, so the data source (currently SQLite) can be swapped in the future without touching business logic or UI

### 🧭 **Navigation**
- **GoRouter** – Declarative, nested routing (`/`, `/settings`, `/settings/about`), replacing manual `Navigator` calls for full-screen navigation

### 🎨 **User Interface & Theming**
- **Material Design 3** – Clean, modern design language
- **Centralized Design System** (`AppColors` / `AppTheme`) – A single source of truth for brand and semantic colors, generating both light and dark `ThemeData`, with the app automatically following the device's system appearance
- **country_flags** – Vector flag icons for the language and currency selectors
- **Custom animations** – Entrance transitions, cascading list animations and micro-interactions throughout the UI

### 🌍 **Internationalization**
- **Flutter Intl (`.arb` files)** – Spanish and English currently supported at the app-content level; the Settings screen already offers French, German and Polish as selectable options ahead of full translation support

---

## 🗺️ Project Structure

Money Tracker follows a **Feature-First + Clean Architecture (lightweight)** approach: code is organized by feature first, and each feature is internally split into `domain` (entities, repository contracts), `data` (repository implementations, data sources) and `presentation` (screens, widgets, Riverpod providers) layers.

```plaintext
📦 lib/
 ┣ 📂 core/
 ┃ ┣ 📂 constants/
 ┃ ┣ 📂 database/
 ┃ ┣ 📂 router/
 ┃ ┃ ┗ 🧭 app_router.dart
 ┃ ┗ 📂 theme/
 ┃   ┣ 🎨 app_colors.dart
 ┃   ┗ 🎨 app_theme.dart
 ┣ 📂 features/
 ┃ ┣ 📂 transactions/
 ┃ ┃ ┣ 📂 data/
 ┃ ┃ ┃ ┣ 📂 datasources/
 ┃ ┃ ┃ ┃ ┗ 💾 transactions_local_datasource.dart
 ┃ ┃ ┃ ┗ 📂 repositories/
 ┃ ┃ ┃   ┗ 📦 transactions_repository_impl.dart
 ┃ ┃ ┣ 📂 domain/
 ┃ ┃ ┃ ┣ 📂 entities/
 ┃ ┃ ┃ ┃ ┗ 💰 transaction.dart
 ┃ ┃ ┃ ┗ 📂 repositories/
 ┃ ┃ ┃   ┗ 📄 transactions_repository.dart
 ┃ ┃ ┗ 📂 presentation/
 ┃ ┃   ┣ 📂 providers/
 ┃ ┃   ┃ ┗ ⚡ transactions_notifier.dart
 ┃ ┃   ┣ 📂 screens/
 ┃ ┃   ┃ ┗ 🏠 home_screen.dart
 ┃ ┃   ┗ 📂 widgets/
 ┃ ┃     ┣ ➕ add_transaction_dialog.dart
 ┃ ┃     ┣ 🗨️ custom_dialog.dart
 ┃ ┃     ┣ 🏠 home_header.dart
 ┃ ┃     ┣ ❓ no_description_dialog.dart
 ┃ ┃     ┣ 🗑️ transaction_delete_dialog.dart
 ┃ ┃     ┣ ⚙️ transaction_options_dialog.dart
 ┃ ┃     ┗ 📋 transactions_list.dart
 ┃ ┗ 📂 settings/
 ┃   ┗ 📂 presentation/
 ┃     ┣ 📂 screens/
 ┃     ┃ ┣ ⚙️ settings_screen.dart
 ┃     ┃ ┗ 👤 about_screen.dart
 ┃     ┗ 📂 widgets/
 ┃       ┣ 🗂️ settings_section.dart
 ┃       ┣ 📄 settings_option_tile.dart
 ┃       ┗ 🔽 settings_expandable_tile.dart
 ┣ 📂 l10n/
 ┃ ┣ 🌐 app_en.arb
 ┃ ┣ 🌐 app_es.arb
 ┃ ┣ 🌍 app_localizations_en.dart
 ┃ ┣ 🌍 app_localizations_es.dart
 ┃ ┗ 🌍 app_localizations.dart
 ┗ 🚀 main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9 or higher)
- Dart SDK (3.9 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/money-tracker.git

# Navigate to project directory
cd money-tracker

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

3. **🗑️ Manage Transactions**  
   Long-press any transaction to edit (coming soon) or delete it

4. **⚙️ Explore Settings**  
   Tap the settings icon on the home screen to open the Settings screen, where you can preview the theme (Light/Dark/System), language, currency and security options

5. **👤 Learn More**  
   From Settings, tap **About** to see a short profile of the developer behind the app

---

## 📝 Roadmap

### 🎯 Upcoming Features

- 🎨 **Real theme switching** – Wire up the existing Light/Dark/System selector to actually change the app's appearance
- 🌍 **Full internationalization** – Connect the language selector to real app-wide translations (French, German, Polish already selectable in the UI)
- 💱 **Real currency formatting** – Apply the selected currency symbol across balances and transactions
- 🔐 **PIN & biometric authentication** – Implement the security options already designed in Settings
- 📊 **Visual Analytics** – Charts and graphs to understand spending patterns over time
- 🎯 **Budget Control** – Monthly budgets with real-time tracking
- 📸 **Receipt Scanner** – Capture and store receipts with OCR technology
- 🌐 **Cloud Sync** – Access your data across multiple devices
- 📅 **Financial Goals** – Set and track long-term savings objectives
- 🔔 **Smart Notifications** – Bill reminders and budget alerts

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

###  Start mastering your finances today!
*Built with Flutter and passion*

<img src="https://media.giphy.com/media/3oKIPa2TdahY8LAAxy/giphy.gif" width="200" alt="Money Animation">

<br><br>

**⭐ If this project helps you manage your money better, give it a star! ⭐**

</div>

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Made with 💙 by <strong>Sergio Sabater</strong>
</div>
