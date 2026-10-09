#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME

# ਯੂਜ਼ਰ ਚੈੱਕ ਕਰਨਾ
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username, frequent_games) VALUES('$USERNAME', 0)" > /dev/null
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
else
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(best_guess) FROM games WHERE user_id=$USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"
read GUESS
TRIES=1

while [[ $GUESS -ne $SECRET_NUMBER ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
  read GUESS
  ((TRIES++))
done

# ਗੇਮ ਅਤੇ ਯੂਜ਼ਰ ਸਟੈਟਸ ਸੇਵ ਕਰਨਾ
$PSQL "INSERT INTO games(user_id, best_guess) VALUES($USER_ID, $TRIES)" > /dev/null
$PSQL "UPDATE users SET frequent_games = frequent_games + 1 WHERE user_id=$USER_ID" > /dev/null

echo "You guessed it in $TRIES tries. The secret number was $SECRET_NUMBER. Nice job!"
