# March 24, 2013
The original puzzle can be found here: http://www.npr.org/2013/03/24/175144673/finding-the-answers-within

## The challenge
Take the four words "salt," "afar," "lava" and "trap." Write them one under the other, and the words will read the same vertically as horizontally. This is a word square of four-letter words. Note that the only vowel in this example square is an A. The object of the challenge is to create a five-letter word square using only common, uncapitalized English words, in which the only vowel in the entire square is A. The word in the center row, and column, is "NASAL".

Graphically, this can be represented as such:

```
_ _ N _ _
_ _ A _ _
N A S A L
_ _ A _ _
_ _ L _ _
```

## Approach
I wanted to try my hand at using Prolog to solve this challenge. It seemed like a natural fit; I'd just program in the possible words, the constraints, and let the computer do all the work. I considered creating a backtracing algorithm in C (since I'm more comfortable in that language) and started down this route, but the Prolog version was way cleaner and so I threw that idea away.

The first thing I needed was a good word list. In the past I've used the `words` file on my Mac (any Unix-like system will probably have the same one, in `/usr/share/dict/words`). However, this word list has a ridiculous number of obscure words that pollute the results. So I searched for a better word list and came across [12dicts](http://wordlist.sourceforge.net/12dicts-readme.html). I settled on the "3esl" as my list of choice for this challenge. 

Now, the first step was to grab all five letter words from the 3esl list. I figured I might as well prefilter the center letter, since as you can see above, it must be one of [N, A, L]. A quick grep later and 517 words match this requirement.

I went through a few different iterations of how to describe the constraints in a Prolog goal. The first few iterations operated on a "word" level, so for example:

```Prolog
wordsquare(A, B, C, D, Words) :-
  select_words([A,B,C,D], Words, NewWords),
  Rows = [A,B,[110,97,115,97,108],C,D], /* "nasal" in the middle */
  transpose(Rows,Columns),
  Rows == Columns.

select_words([A|As], WordList, NewWordList) :-
  select(A, WordList, NewWordList),
  select_words(As, NewWordList, Z).
  select_words([], Z, Z).
```

Unfortunately, this didn't end well. With a word square any larger than 3x3, the wordsquare rule would spin my CPU indefinitely. I killed it after an hour.

## Solution
Originally I had started documenting the constraints of each letter position, but had discarded that idea on my way to the `wordsquare` goal above. As it turns out, my wife independently completed the list of constraints and was on her way to solving it by hand. So if the matrix looks like:

```
 1  2  N  3  4
 5  6  A  7  8
 N  A  S  A  L
 9 10  A 11 12
13 14  L 15 16
```

Then the equivalencies described in the original problem reduces the matrix to:

```
 1  2  N  4  5
 2  6  A  7  8
 N  A  S  A  L
 4  7  A  9 10
 5  8  L 10 11
```

Now a simple Prolog predicate can be written to find words that match this pattern:

```Prolog
solve(Words) :-
  member([A1, A2, 110, A4, A5], Words),
  member([A2, A6,  97, A7, A8], Words),
  member([A4, A7,  97, A9, A10], Words),
  member([A5, A8, 108, A10, A11], Words),
```

## Running the Program
The Prolog code is tested on SWI Prolog 6.2.6 as installed through Homebrew on Mac OS X. Just run "make" with the included Makefile, and run the resulting executable `2013-03-24-puzzler`. Invoke the `solve` goal by typing `solve.` (note the trailing period) and hit Enter. Hit space after each candidate solution is displayed.

```
Welcome to SWI-Prolog (Multi-threaded, 64 bits, Version 6.2.6)
Copyright (c) 1990-2012 University of Amsterdam, VU Amsterdam
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software,
and you are welcome to redistribute it under certain conditions.
Please visit http://www.swi-prolog.org for details.

For help, use ?- help(Topic). or ?- apropos(Word).

?- solve.
lined
inane
nasal
enact
delta
true ;

panda
apart
nasal
drama
atlas
true ;

ranch
aware
nasal
crawl
hello
true ;

false.

?- 
```

Note that only one solution (the second one above) is correct, as the original problem also stipulated that the only allowable vowel is "a".

