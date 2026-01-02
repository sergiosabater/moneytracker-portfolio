# 💰 Money Tracker

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue?style=for-the-badge&logo=flutter" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart" alt="Language">
  <img src="https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Framework">
  <img src="https://img.shields.io/badge/State-Provider%2FRiverpod-purple?style=for-the-badge" alt="State Management">
  <img src="https://img.shields.io/badge/Mode-Dark%20%26%20Light-yellow?style=for-the-badge&logo=flutter" alt="Theme Mode">
</div>

<div align="center">

### 💸 Take Control of Your Financial Future! 💸
*The smart way to track every penny, visualize your spending, and achieve your financial goals.*

</div>

---

## 📱 About the Project

**Money Tracker** is your personal financial companion, designed to help you master your money management.  
From tracking daily expenses to analyzing spending patterns, discover the power of financial awareness and make smarter decisions with every transaction.

### ✨ What Makes Money Tracker Special?

- 💳 **Complete Transaction Management** – Add, edit, and track all your income and expenses effortlessly
- 📊 **Visual Analytics** – Beautiful charts and graphs to understand your financial habits at a glance
- 🎯 **Smart Budget Control** – Set monthly budgets and stay on track with real-time monitoring
- 🔄 **Recurring Payments** – Never forget regular bills or income streams
- 🌓 **Adaptive Theming** – Seamlessly switch between dark and light modes
- 🌍 **Multi-Currency Ready** – Track finances in any currency worldwide
- 🔐 **Bank-Level Security** – Protect your data with PIN or biometric authentication
- 📱 **Cross-Platform** – Native experience on both iOS and Android

---

## 📸 Screenshots

<div align="center">
  <img src="placeholder-dashboard.png" width="250" alt="Dashboard"> &nbsp;&nbsp;
  <img src="placeholder-analytics.png" width="250" alt="Analytics"> &nbsp;&nbsp;
  <img src="placeholder-budget.png" width="250" alt="Budget Tracking"> &nbsp;&nbsp;
</div>

*Screenshots coming soon to showcase the beautiful UI!*

---

## 🛠️ Tech Stack

### 🏗️ **Framework & Architecture**
- **Flutter** – Cross-platform framework for native iOS & Android apps
- **Dart** – Fast, modern programming language optimized for UI
- **Clean Architecture** – Maintainable, scalable, and testable codebase

### 💉 **State Management**
- **Provider / Riverpod** – Reactive and efficient state management solution

### 💾 **Data Persistence**
- **SQLite / Hive** – Local database for fast and reliable data storage
- **Backup & Restore** – Export/import functionality for data safety

### 📊 **Visualization**
- **fl_chart** – Stunning graphs, pie charts, and analytics visualization
- **Custom Widgets** – Beautiful UI components for an engaging experience

### 🔐 **Security**
- **Local Authentication** – PIN code and biometric protection
- **Encrypted Storage** – Your financial data stays private and secure

### 🎨 **User Interface**
- **Material Design** – Clean, intuitive, and modern design language
- **Dark & Light Themes** – Comfortable viewing in any lighting condition
- **Responsive Layout** – Perfect experience on phones and tablets

---

## 🗺️ Project Structure

Money Tracker follows a **feature-based modular architecture** for maximum maintainability:

```plaintext
📦 lib/
 ┣ 📂 core/
 ┃ ┣ 📂 constants/
 ┃ ┃ ┗ 📜 app_constants.dart
 ┃ ┣ 📂 theme/
 ┃ ┃ ┣ 🎨 app_colors.dart
 ┃ ┃ ┣ 🌓 app_theme.dart
 ┃ ┃ ┗ ✍️ text_styles.dart
 ┃ ┣ 📂 utils/
 ┃ ┃ ┣ 📅 date_formatter.dart
 ┃ ┃ ┣ 💱 currency_formatter.dart
 ┃ ┃ ┗ 🧮 calculations.dart
 ┃ ┗ 📂 widgets/
 ┃   ┣ 🔘 custom_button.dart
 ┃   ┣ 📝 custom_text_field.dart
 ┃   ┗ 💳 transaction_card.dart
 ┣ 📂 features/
 ┃ ┣ 📂 transactions/
 ┃ ┃ ┣ 📂 data/
 ┃ ┃ ┃ ┣ 📂 models/
 ┃ ┃ ┃ ┃ ┗ 💰 transaction_model.dart
 ┃ ┃ ┃ ┣ 📂 repositories/
 ┃ ┃ ┃ ┃ ┗ 📜 transaction_repository.dart
 ┃ ┃ ┃ ┗ 📂 datasources/
 ┃ ┃ ┃   ┗ 💾 local_datasource.dart
 ┃ ┃ ┣ 📂 domain/
 ┃ ┃ ┃ ┗ 📂 usecases/
 ┃ ┃ ┃   ┣ 📜 add_transaction.dart
 ┃ ┃ ┃   ┣ 📜 get_transactions.dart
 ┃ ┃ ┃   ┗ 🗑️ delete_transaction.dart
 ┃ ┃ ┗ 📂 presentation/
 ┃ ┃   ┣ 📂 screens/
 ┃ ┃   ┃ ┣ 🖼 transaction_list_screen.dart
 ┃ ┃   ┃ ┗ 📝 add_transaction_screen.dart
 ┃ ┃   ┗ 📂 providers/
 ┃ ┃     ┗ 📦 transaction_provider.dart
 ┃ ┣ 📂 analytics/
 ┃ ┃ ┣ 📂 presentation/
 ┃ ┃ ┃ ┣ 📂 screens/
 ┃ ┃ ┃ ┃ ┗ 📊 analytics_screen.dart
 ┃ ┃ ┃ ┗ 📂 widgets/
 ┃ ┃ ┃   ┣ 🥧 pie_chart_widget.dart
 ┃ ┃ ┃   ┣ 📈 line_chart_widget.dart
 ┃ ┃ ┃   ┗ 📊 bar_chart_widget.dart
 ┃ ┣ 📂 budget/
 ┃ ┃ ┣ 📂 data/
 ┃ ┃ ┃ ┗ 📂 models/
 ┃ ┃ ┃   ┗ 🎯 budget_model.dart
 ┃ ┃ ┗ 📂 presentation/
 ┃ ┃   ┗ 📂 screens/
 ┃ ┃     ┗ 🎯 budget_screen.dart
 ┃ ┣ 📂 categories/
 ┃ ┃ ┣ 📂 data/
 ┃ ┃ ┃ ┗ 📂 models/
 ┃ ┃ ┃   ┗ 🏷️ category_model.dart
 ┃ ┃ ┗ 📂 presentation/
 ┃ ┃   ┗ 📂 screens/
 ┃ ┃     ┗ 🏷️ categories_screen.dart
 ┃ ┗ 📂 settings/
 ┃   ┗ 📂 presentation/
 ┃     ┗ 📂 screens/
 ┃       ┗ ⚙️ settings_screen.dart
 ┣ 🏠 main.dart
 ┗ 🌍 app.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
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

# Run the app
flutter run
```

---

## 💡 Usage Guide

1. **🎯 Create Your First Transaction**  
   Tap the **"+"** button to add income or expenses instantly

2. **🏷️ Organize with Categories**  
   Customize categories like Food, Transport, Entertainment, and more

3. **📊 Discover Insights**  
   Visit the **Analytics** tab to see beautiful charts showing your spending patterns

4. **💰 Set Your Budget**  
   Define monthly budgets and monitor progress with real-time tracking

5. **🔍 Search & Filter**  
   Quickly find any transaction by date, category, or amount

6. **🔐 Stay Secure**  
   Enable PIN or biometric authentication to protect your financial data

---

## 📝 Roadmap

### 🎯 Upcoming Features

- 🤖 **AI-Powered Insights** – Smart recommendations based on your spending habits
- 📱 **Bank Integration** – Connect directly to your bank accounts
- 👥 **Shared Budgets** – Collaborate on finances with family or roommates
- 📸 **Receipt Scanner** – Capture and store receipts with OCR technology
- 🌐 **Cloud Sync** – Access your data across multiple devices
- 📅 **Financial Goals** – Set and track long-term savings objectives
- 📈 **Investment Tracking** – Monitor stocks, crypto, and other assets
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
**GitHub:** [@yourusername](https://github.com/yourusername)  
**LinkedIn:** [Your Profile](https://linkedin.com/in/yourprofile)

---

<div align="center">

### 💪 Start mastering your finances today! 💪
*Built with ❤️, Flutter, and a passion for financial freedom.*

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
