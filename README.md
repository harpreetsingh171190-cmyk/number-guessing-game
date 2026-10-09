# Number Guessing Game

An interactive terminal-based guessing game built with **Bash**, **PostgreSQL**, and **Git**. This project tracks user game history, total games played, and best scores across sessions.

---

## Features

- **User Tracking:** Automatically detects new versus returning players and greets them accordingly.
- **Persistent Gameplay Stats:** Stores total games played and fewest guesses (best game) in PostgreSQL.
- **Input Validation:** Handles non-integer guesses seamlessly without crashing.
- **Version Controlled:** Developed following standard Git version control best practices.

---

## Database Architecture

- **`users`**:
  - `user_id` (SERIAL, PRIMARY KEY)
  - `username` (VARCHAR(22), UNIQUE)
- **`games`**:
  - `game_id` (SERIAL, PRIMARY KEY)
  - `user_id` (INT, FOREIGN KEY -> `users.user_id`)
  - `guesses` (INT)

---

## Setup & Running

1. **Restore Database:**
   ```bash
   psql -U postgres < number_guess.sql
