# University Info System For Firat University

## [Youtube Video](https://youtu.be/MtTINIelL4o)

[Click to open video](https://youtu.be/MtTINIelL4o)

![my_uni tambnail](https://github.com/Utku-Mese/University-Info-System-For-Firat-University/assets/94257756/23ed7eb8-f01f-4041-aa84-4fc79d7957fc)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Contributions](#contributions)
- [License](#license)

## Overview

The University Info System is a application designed to manage and display information related to lessons, students, and instructors within a university. It provides a user-friendly interface and a API for accessing and manipulating university data.

The API runs on port 8000 by default.

You can access the API at http://localhost:8000/api/

note: You can access database tables with .sql extension from the "db tables" folder.

## In App Screenshots

You can find it in the "screenshot" folder.

## Features

- View a list of all lessons, students, and instructors.
- Detailed information about each lesson, student, and instructor.
- Add new lessons, students, and instructors.
- Update existing lesson, student, and instructor details.
- Delete lessons, students, and instructors when needed.
- API endpoints for programmatic access to university data.

## MVC Architecture

This project follows the MVC (Model-View-Controller) architectural pattern, which helps in organizing and managing the codebase effectively. By adhering to the MVC architecture, the project achieves a clear separation of concerns, making it easier to manage and extend in the future. The Model, View, and Controller components collaborate harmoniously to provide a robust and maintainable system for managing university information.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Node.js, npm and flutter installed on your development machine.
- MySQL database with appropriate tables and configuration.
- Clone this repository to your local machine.

### Installation

To install and run the project locally, follow these steps:

1. Navigate to the database directory:

   ```shell
   cd University-Info-System-For-Firat-University/database

2. Install the project dependencies:

    ```shell
    npm install

3. Configure the database settings:

* Open the config.js file and set your MySQL database connection details.

4. Start the server:

    ```shell
    node index.js

    ```
    or
    ```shell
    npm start
    
5. Navigate to the project directory:

    ```shell
    cd ..

6. run "flutter pub get":

    ```shell
    flutter pub get

7. Start the application:

    ```shell
    flutter run

## Contributions

Contributions are welcome! If you find a bug or want to add new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](/LICENSE).

---

### Designed and developed with by [Mehmet Utku Meşe](https://www.linkedin.com/in/mehmet-utku-mese/).


