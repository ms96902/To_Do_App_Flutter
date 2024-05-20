# QuickTask

QuickTask is a to-do management application built using Flutter and Back4App. The app allows users to sign up, log in, and manage their tasks efficiently. Users can add, update, delete tasks, and mark them as completed. Each task also has a due date.

## Features

- User authentication (sign up and log in)
- Add new tasks with a due date and completion status
- Update existing tasks
- Delete tasks
- Mark tasks as completed
- Responsive UI

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter
- A Back4App account: [Sign up here](https://www.back4app.com/)

### Clone the Repository

```sh
git clone https://github.com/yourusername/quicktask.git
cd quicktask

Configure Backend
Back4App Setup: Create a new application on Back4App and configure the necessary classes (User, Task, etc.).
Back4App Credentials: Obtain your Application ID and Client Key from Back4App.
Environment Configuration: Update the lib/config/back4app_config.dart file with your Back4App credentials.

const String APPLICATION_ID = 'YOUR_APPLICATION_ID';
const String CLIENT_KEY = 'YOUR_CLIENT_KEY';
const String SERVER_URL = 'https://parseapi.back4app.com/';



Sure! Below is a template for a comprehensive README file for your Flutter to-do management app, QuickTask, which uses Back4App for the backend.

markdown
Copy code
# QuickTask

QuickTask is a to-do management application built using Flutter and Back4App. The app allows users to sign up, log in, and manage their tasks efficiently. Users can add, update, delete tasks, and mark them as completed. Each task also has a due date.

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Built With](#built-with)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Features

- User authentication (sign up and log in)
- Add new tasks with a due date and completion status
- Update existing tasks
- Delete tasks
- Mark tasks as completed
- Responsive UI

## Screenshots

![Login Screen](screenshots/login_screen.png)
![Task List Screen](screenshots/task_list_screen.png)
![Add Task Screen](screenshots/add_task_screen.png)

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter
- A Back4App account: [Sign up here](https://www.back4app.com/)

### Clone the Repository

```sh
git clone https://github.com/yourusername/quicktask.git
cd quicktask
Configure Backend
Back4App Setup: Create a new application on Back4App and configure the necessary classes (User, Task, etc.).
Back4App Credentials: Obtain your Application ID and Client Key from Back4App.
Environment Configuration: Update the lib/config/back4app_config.dart file with your Back4App credentials.
dart
Copy code
const String APPLICATION_ID = 'YOUR_APPLICATION_ID';
const String CLIENT_KEY = 'YOUR_CLIENT_KEY';
const String SERVER_URL = 'https://parseapi.back4app.com/';


Code Make below change in main.dart file with your credentials which you will get from back4app
await Parse().initialize(
    'YOUR_APPLICATION_ID',
    'https://parseapi.back4app.com',
    clientKey: 'YOUR_CLIENT_KEY',
    autoSendSessionId: true,
  )
Install Dependencies
  flutter pub get

Run the App
  flutter run


Usage
Sign Up: Create a new account using your email and password.
Log In: Log in with your credentials.
Add Tasks: Add new tasks with a title, due date, and completion status.
Manage Tasks: Update or delete tasks, and mark them as completed.


Built With
Flutter - UI toolkit for building natively compiled applications
Back4App - Backend-as-a-Service platform
Parse SDK for Flutter - SDK used for integrating Back4App
