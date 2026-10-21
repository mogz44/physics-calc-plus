# Physics Calc+ ⚛️📱

> **A modern, dynamic physics assistant powered by a chained Inference Engine and a comprehensive Unit Converter for mobile.**

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Flutter](https://img.shields.io/badge/Flutter-3.41+-02569B?logo=flutter)](https://flutter.dev)
[![F-Droid Compatible](https://img.shields.io/badge/F--Droid-Ready-3DDC84?logo=f-droid)](https://f-droid.org/)
[![Privacy: Offline](https://img.shields.io/badge/Privacy-100%25%20Offline-success)](https://github.com/muhammedoguz/PhysicsCalc)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/muhammedoguz/PhysicsCalc/pulls)

---

## 📌 Overview

Traditional physics calculator apps constrain users into rigid, isolated formula forms. **Physics Calc+** takes a fundamentally different approach: you supply **any arbitrary set of known physical quantities**, and its internal **Inference Engine** dynamically navigates a graph of physics equations to iteratively derive all possible unknown variables.

For example, by simply providing **Mass ($m$)**, **Velocity ($v$)**, and **Time ($t$)**, the engine automatically cascades through:
1. Kinematics for **Acceleration ($a = v / t$)**,
2. Newton's 2nd Law for **Net Force ($F = m \cdot a$)**,
3. Kinetic Energy for **Energy ($E_k = \frac{1}{2}m v^2$)**,
4. Linear Momentum for **Momentum ($p = m \cdot v$)**,
5. Uniform Motion for **Displacement ($d = v \cdot t$)**,
6. Work-Energy Principle for **Work Done ($W = F \cdot d$)**,
7. Power Definition for **Mechanical Power ($P = W / t$)**

All derived quantities, their SI units, and a step-by-step mathematical solution tree are produced instantly.

---

## ✨ Features

### 1. Physics Calc+ (Inference Engine Screen)
- **3-Column Dynamic Input Rows:**
  - **Left Column:** Searchable, categorized picker modal (Mechanics, Electricity, etc.) featuring symbols and descriptive icons.
  - **Middle Column:** Numerical decimal input field (`TextField`).
  - **Right Column:** Dynamic unit selector prepopulated with standard SI units and non-SI alternatives ($km/h$, $mph$, $dyne$, $lbf$, $bar$, $psi$, etc.).
- **Dynamic Row Management:** Starts with 2 default rows; add or remove inputs on the fly with the `+ Add Value` button.
- **Real-Time Chained Resolution:** Equations are evaluated as you type without blocking the UI.
- **Step-by-Step Solution Tree:** An inspectable modal sheet revealing which formula was applied at each step, what inputs were substituted, and the resulting values.

### 2. Physics Converter (Unit Converter Screen)
- Seamless unit conversion across all standard physical quantities.
- Two-way instant conversion with a quick swap (`⇄`) toggle.
- **Simultaneous Equivalent Table:** Entering a single value displays that quantity converted across all known units at a glance.

---

## 🧠 Inference Engine Architecture

- **Explicit Algebraic Rearrangements (Derivatives):** Rather than using generic symbolic solvers that are computationally heavy on mobile, relationships are modeled as explicit directed rules:
  - $F = m \cdot a$
  - $m = F / a$ (Guarded against division by zero: `if (a != 0)`)
  - $a = F / m$ (Guarded against division by zero: `if (m != 0)`)
- **SI Base Normalization:** Any user input is immediately normalized to its SI base unit before inference begins. Calculations operate strictly in SI units.
- **Collision-Free Unique Identifiers:** Physical quantities that share traditional symbols are decoupled using unique system IDs (`work_W` vs `weight_W`, `power_P` vs `pressure_P`).
- **v2.0 Multi-Body Extensibility:** Data structures are engineered to accept `bodyId` and `systemId` properties, paving the way for multi-body collision and planetary mechanics in future releases.

---

## 🛡️ F-Droid & Privacy Principles

- **100% Free & Open Source Software (FLOSS):** Released under the **GNU General Public License v3.0 (GPL-3.0)**.
- **Zero Telemetry / No Tracking:** No analytics SDKs, crash reporters, or advertising frameworks.
- **Completely Offline:** Operates entirely on-device without internet access.
- **No Proprietary Blobs:** Complies fully with F-Droid and open-source repository inclusion guidelines.

---

## 📂 Project Structure

```text
lib/
├── app.dart                          # MaterialApp & theme configuration
├── main.dart                         # Application entrypoint
├── main_navigation_screen.dart       # Bottom navigation bar (Calc+ & Converter)
│
├── core/
│   ├── theme/app_theme.dart          # Scientific Light & Dark Theme
│   └── utils/number_formatter.dart   # Smart decimal and scientific notation formatter
│
└── features/
    ├── common_physics/               # Shared physics domains
    │   ├── models/                   # PhysicsQuantity, PhysicsUnit, PhysicsCategory
    │   └── data/                     # StandardQuantities, StandardUnits
    │
    ├── calc_engine/                  # Core Inference Engine & UI
    │   ├── engine/inference_engine.dart # Iterative chained resolution loop
    │   ├── models/                   # Formula, InferenceResult, InferenceStep, InputRowModel
    │   ├── data/standard_formulas.dart# 40+ explicitly solved physics formulas
    │   └── presentation/             # CalcScreen, InputRowWidget, modals
    │
    └── converter/                    # Physics Converter screen
        └── presentation/screens/converter_screen.dart
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev) (v3.24 or higher recommended)
- Dart SDK (v3.5 or higher)

### Build & Run
```bash
# Clone the repository
git clone https://github.com/muhammedoguz/PhysicsCalc.git
cd PhysicsCalc

# Install dependencies
flutter pub get

# Run automated tests
flutter test

# Launch the application
flutter run
```

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**. See the [LICENSE](LICENSE) file for complete details. You are free to run, study, modify, and redistribute this software.

---

## 🤖 AI-Assisted Development Notice

This project was architected, written, and refined with the assistance of advanced AI coding assistants (such as Google Antigravity & LLM pair programming tools). All algorithmic designs, physics formula models, and automated tests were verified, reviewed, and tested for accuracy, security, and standards compliance.