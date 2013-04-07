:- use_module(library(error)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).

solve :-
  load_file('nasal_words.txt', Words),
  member([A1, A2, 110, A4, A5], Words),
  member([A2, A6,  97, A7, A8], Words),
  member([A4, A7,  97, A9, A10], Words),
  member([A5, A8, 108, A10, A11], Words),
  writef("%s\n", [[A1,A2,110,A4,A5]]),
  writef("%s\nnasal\n", [[A2, A6,  97, A7, A8]]),
  writef("%s\n", [[A4, A7,  97, A9, A10]]),
  writef("%s\n", [[A5, A8, 108, A10, A11]]).

load_file(File, Words) :-
  open(File, read, Stream, []),
  call_cleanup(load_strings(Stream,Words), close(Stream)).

load_strings(Stream, Words) :-
  read_line_to_codes(Stream, T0),
  load_strings(T0, Stream, Words).

/* the next two predicates used to have _ instead of [], which caused problems. */
load_strings(end_of_file, _Stream, []) :- !.
load_strings([], _Stream, []) :- !.
load_strings(Line, Stream, [Line|Rest]) :-
  read_line_to_codes(Stream, NextLine),
  load_strings(NextLine, Stream, Rest).

