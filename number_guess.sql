DROP DATABASE IF EXISTS number_guess;
CREATE DATABASE number_guess;
\connect number_guess

CREATE TABLE public.users (
    user_id SERIAL PRIMARY KEY,
    username character varying(22) NOT NULL UNIQUE,
    frequent_games integer DEFAULT 0 NOT NULL
);

CREATE TABLE public.games (
    game_id SERIAL PRIMARY KEY,
    user_id integer NOT NULL REFERENCES public.users(user_id),
    best_guess integer DEFAULT 0 NOT NULL
);

ALTER TABLE public.users OWNER TO freecodecamp;
ALTER TABLE public.games OWNER TO freecodecamp;
