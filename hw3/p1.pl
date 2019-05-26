% find Goldbach's conjecture

prime(2).
prime(3).
prime(X) :-
    X > 3,
    X mod 2 =\= 0,
    \+ has_factor(X, 1).

has_factor(Num, I) :-
    Odd is 2 * I + 1,
    Num mod Odd =:= 0,
    !.
has_factor(Num, I) :-
    Odd is 2 * I + 1,
    Odd * Odd < Num,
    I2 is I + 1,
    has_factor(Num, I2).

goldbach(N, P, Q) :-
    prime(P),
    Q is N - P,
    prime(Q),
    !,
    format('~d ~d~n', [P, Q]).
goldbach(N, P, _) :-
    NextP is P + 1,
    goldbach(N, NextP, _).


main :-
    current_input(InputStream),
    repeat,
    read_string(InputStream, "\n ", "\r\t", _, Str),
    number_string(Input, Str),
    ignore(goldbach(Input, 2, _)),
    at_end_of_stream(InputStream),
    halt.

:- initialization(main).