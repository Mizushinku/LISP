% Reachable

/*
reachable(A, B, 1) :-
    connected(A, B),
    !.
reachable(A, B, S) :-
    S > 1,
    connected(A, X),
    Sp is S - 1,
    reachable(X, B, Sp).


is_reachable(A, B, S, M) :-
    S =< M,
    reachable(A, B, S),
    !.
is_reachable(A, B, S, M) :-
    Sp is S + 1,
    is_reachable(A, B, Sp, M).
*/

has_path(A, B, Path) :-
    connected(A, X),
    \+ member(X, Path),
    (B == X ; has_path(X, B, [A|Path])).

reachable(A, B) :-
    has_path(A, B, []),
    !.


find_reachable(InputStream, M) :-
    M > 0,
    read_string(InputStream, "\n ", "\r\t", _, N1),
    read_string(InputStream, "\n ", "\r\t", _, N2),
    number_string(N1_num, N1),
    number_string(N2_num, N2),
    (reachable(N1_num, N2_num)
        -> writeln('Yes')
        ; writeln('No')
    ),
    Mp is M - 1,
    find_reachable(InputStream, Mp).

make_connect(InputStream, E) :-
    E > 0,
    read_string(InputStream, "\n ", "\r\t", _, N1),
    read_string(InputStream, "\n ", "\r\t", _, N2),
    number_string(N1_num, N1),
    number_string(N2_num, N2),
    %assertz(connected(N1_num, N1_num)),
    assertz(connected(N1_num, N2_num)),
    assertz(connected(N2_num, N1_num)),
    %assertz(connected(N2_num, N2_num)),
    Ep is E - 1,
    make_connect(InputStream,Ep).

main :-
    current_input(InputStream),
    read_string(InputStream, "\n ", "\r\t", _, _),
    read_string(InputStream, "\n ", "\r\t", _, Str2),
    %number_string(N, Str1),
    number_string(E, Str2),
    ignore(make_connect(InputStream, E)),
    read_string(InputStream, "\n ", "\r\t", _, Str3),
    number_string(M, Str3),
    ignore(find_reachable(InputStream, M)),
    halt.

:- initialization(main).