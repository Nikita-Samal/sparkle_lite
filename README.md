Sparkle Lite – Health Tracking App
-----------

A Flutter-based health tracking application designed to help users log symptoms, view health history, and get basic insight suggestions from their data.

Built as a frontend-focused project to demonstrate scalable Flutter architecture, state management, and responsive UI design for both mobile and web.

---

Overview
---

Sparkle Lite is a personal health tracking app where users can:

* log daily symptoms
* track health-related information
* view structured history and timelines
* explore basic AI-style insights (rule-based logic)

The main focus of this project was building a **clean, scalable Flutter frontend with good architecture and multi-platform support (mobile + web).**

---

 Key Features
--------

* Symptom logging system
*  Symptom history & timeline view
*  Health records UI (mock data structure)
*  Rule-based AI insight generation (frontend logic)
*  Doctor visit summary UI (mock flow)
*  Privacy & settings screens
*  Family module UI structure
*  Responsive design for mobile and web

---

Tech Stack
-------

* Flutter
* Dart
* Bloc / Cubit (State Management)
* go_router (Navigation)
* Flutter Web support


Architecture
---------

The app follows a **feature-first modular structure** to keep the code clean and scalable.


lib/
 core/
   theme/
   routing/
   utils/
   widgets/

 features/
   auth/
   dashboard/
   symptom_tracker/
   records/
   timeline/
   ai_insights/
   doctor_visit/
   privacy/
   family/


Each feature contains its own UI and state logic, making the project easier to scale and maintain.



State Management

I used Bloc  managing state.

Why I chose it:

* Keeps UI and logic separated
* Works well for multiscreen apps
* Makes state transitions predictable
* Easier debugging compared to tightly coupled state handling



Navigation

Navigation is handled using **go_router**.

It helps manage:

* clean route structure
* web + mobile navigation consistency
* scalable routing for multiple modules



Platform Support

* ✔ Android
* ✔ iOS (basic support)
* ✔ Web (responsive UI implemented)

Web UI is designed using a centered layout approach to avoid stretched mobile-style screens.



 Limitations

Since this is a frontend-focused project:

* No real backend integration
* Data is currently mock / locally handled
* AI insights are rule-based (not real AI/ML)
* No persistent cloud storage
* No authentication system implemented

---

Testing

Basic testing included:

Unit Tests

* Symptom validation logic
* Privacy settings logic
* AI insight generation rules

Widget Tests

* Login form validation
* Dashboard rendering states
* Empty state handling



 What I Learned

This project helped me improve in:

* structuring a scalable Flutter application
* managing state using Bloc
* building responsive UI for mobile and web
* handling real-world edge cases like empty states and loading states
* separating features into clean modules instead of mixing logic

Future Improvements

If I extend this project, I would:

* add real backend integration (Firebase or custom API)
* improve AI insights using real models or APIs
* implement offline storage support
* enhance UI polish for production-level design
* add analytics for symptom trends
* improve test coverage and CI setup


bash
git clone <repo-url>
cd sparkle_lite
flutter pub get
flutter run
```
Run  on Web

bash 
flutter run -d chrome

