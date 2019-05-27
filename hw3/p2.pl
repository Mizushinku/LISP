% Lowest Common Ancestor

ancestor(A, B) :- parent(A, B).
ancestor(A, B) :- parent(X, B), ancestor(A, X).

lca(A, B, LCA) :-
    ancestor(LCA, A),
    ancestor(LCA, B),
    !.

find_lca(InputStream, N) :-
    N > 0,
    read_string(InputStream, "\n ", "\r\t", _, N1),
    read_string(InputStream, "\n ", "\r\t", _, N2),
    number_string(N1_num, N1),
    number_string(N2_num, N2),
    lca(N1_num, N2_num, LCA),
    writeln(LCA),
    M is N - 1,
    find_lca(InputStream, M).

make_relation(InputStream, N) :-
    N > 0,
    read_string(InputStream, "\n ", "\r\t", _, P),
    read_string(InputStream, "\n ", "\r\t", _, C),
    %atom_string(PA, P),
    %atom_string(CA, C),
    number_string(PA, P),
    number_string(CA, C),
    %Fact =.. ['parent', PA, CA],
    %assertz(Fact),
    assertz(parent(PA, CA)),
    M is N -1,
    make_relation(InputStream, M).

main :-
    current_input(InputStream),
    read_string(InputStream, "\n ", "\r\t", _, Str1),
    number_string(Input1, Str1),
    R is Input1 - 1,
    ignore(make_relation(InputStream, R)),
    read_string(InputStream, "\n ", "\r\t", _, Str2),
    number_string(Input2, Str2),
    ignore(find_lca(InputStream, Input2)),
    halt.


:- initialization(main).