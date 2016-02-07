For this project, I used ruby to build and implementation of the game [Mastermind](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29)

### Learning Goals / Areas of Focus

* Apply principles of flow control across multiple methods
* Practice breaking a program into logical components
* Learn to implement a REPL interface
* Apply Enumerable techniques in a real context

### Usage

The game is played through the command line like so:
```
$ ./mastermind
Welcome to MASTERMIND

Would you like to (p)lay, read the (i)nstructions, or (q)uit?
>
```

* `p` or `play` will start the game
* `i` or `instructions` will present a brief explanation of the how the game is played
* `q` or `quit` will exit the game

### Game Flow

Once a game is started, the player will see the following:
```
I have generated a beginner sequence with four elements made up of: (r)ed,
(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.
What's your guess?
```

They can then enter a guess in the form `rrgb`

* `'q'` or `'quit'` will still provide the option to exit the game
* `'c'` or `'cheat'` will reveal the final answer
* Players are prompted to try again if their answer is too long or too short
* Feedback is also given for partially correct answers, as seen in the example below:

```
'RRGB' has 3 of the correct elements with 2 in the correct positions
You've taken 1 guess
```

The player can then guess again, using that information to work towards the final answer

When the user correctly guesses the sequence, they're greeted with the following message:

```
Congratulations! You guessed the sequence 'GRRB' in 8 guesses over 4 minutes,
22 seconds.

Do you want to (p)lay again or (q)uit?
```

If the player enters `'p'` or `'play'` then the game will start over. Otherwise, `'q'` or `'quit'` can be used to end the game
