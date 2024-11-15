# my stupid wordle clone
i'm the last person in the world to have ever tried to play wordle. i just did it for the first time over thanksgiving 2023. it seemed fun, but i didn't wanna sign up for stuff.

so i spent about 90 minutes and wrote a super crappy version in my favorite language -- ruby. you can play it in a terminal.

## dictionary design
there are 3 different dictionaries being utilized by the game. 2 are in this repo -- the [dictionaries/answers.txt](dictionaries/answers.txt) file has all the possible answers that can be included in the puzzle, and the [dictionaries/dictionary.txt](dictionaries/dictionary.txt) that includes a larger list of words that you can use as guesses. the latter is augmented by macos' `/usr/share/dict/words` file. i was running up against issues finding a good source of reasonable words that could be considered valid.

## weirdness
since i only ever played the real version 2 or 3 times, i'm not sure i've gotten all the rules right. there's something weird about double letters. imagine the game had the word `DAISY` as the one to guess. if you were to enter `DADDY` as your guess, i'm not sure what i should do with the second and third D. should they be yellow, because the real D is in position 1, or should they be unhighlighted, because all the other Ds are exhausted.

## usage
### setup (one time only)
open your favorite terminal, and run:
```bash
$ bundle install
```

### play
head back to that favorite terminal, and run:
```bash
$ rake wordle:play
```

it just plays one game at a time. if you want to bail in the middle, ctrl-c will do it.

## cheating at real wordle
if you're stuck on something, update the [solver.yml](solver.yml) file based on the guesses you've already made, and then use `wordle:solve`:
```bash
$ rake "wordle:solve[solver.yml]"
```

you'll be provided with a narrowed-down list of candidate words that conform to the constraints you've provided.