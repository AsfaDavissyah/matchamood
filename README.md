# matcha

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 🍵 Matcha Mood — Flutter Mobile App  
A modern, minimalistic matcha restaurant mobile app built with Flutter.  
This application showcases menu browsing, category filtering, search functionality, and clean UI components.

---

## 🚀 Features

### ✅ Home Page  
- Banner promo  
- Category tabs (All + dynamic categories from API)  
- Search menu with realtime filtering  
- Recommended menu grid  
- Bottom navigation bar  

### ✅ Menu  
- Fetch all menu items from TheMealDB API  
- Filter menu by category  
- Fully dynamic UI using responsive Flutter widgets  

### ✅ Detail Page  
- Display full menu detail  
- Ingredients list  
- Instructions  
- Image preview  
- Quantity counter  
- Add to cart button (dummy action)  

### 🎨 UI Components  
- `banner_home.dart`  
- `category_home.dart`  
- `search_bar_section.dart`  
- `menu_card_home.dart`  
- `header_home.dart`  

---

## 📦 Tech Stack

| Component | Technology |
|----------|------------|
| Framework | Flutter |
| State Management | StatefulWidget (basic) |
| API Provider | TheMealDB |
| HTTP Client | `http` package |
| Language | Dart |
| Architecture | Simple MVC (Model - Service - UI) |

---

## 📁 Folder Structure

lib/
├── model/
│ └── meal.dart **#model untuk uas**
| └── menu_model.dart **#model untuk uts**
├── services/
│ └── meal_service.dart
├── page/
│ ├── home_page.dart
│ ├── menu_page.dart
│ └── detail_page.dart
├── widget/
│ ├── banner_home.dart
│ ├── category_home.dart
│ ├── search_bar_section.dart
│ ├── menu_card_home.dart
│ └── header_home.dart
├── theme/
│ └── app_theme.dart
└── main.dart


---

## 🔗 API Used

App ini menggunakan API open-source dari **TheMealDB**:  
- Get all meals:  
  `https://www.themealdb.com/api/json/v1/1/search.php?s=`
- Get categories:  
  `https://www.themealdb.com/api/json/v1/1/list.php?c=list`

---

## 🛠 Setup & Installation

### 1️⃣ Clone the project
```sh
git clone https://github.com/AsfaDavissyah/matchamood.git


By: Asfa Davissyah 230605110186