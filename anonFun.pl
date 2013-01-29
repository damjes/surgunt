substAB(L, do(P) -> Cont, R) :-
	nonvar(P),
	call(P),
	substAB(L, Cont, R).
substAB([], X -> Y, X -> Y) :-
	var(X).
substAB([], X, X) :-
	X \= do(_),
	X \= (do(_) -> _).
substAB([X|Xs], X -> Cont, R) :-
	substAB(Xs, Cont, R).

subst(V, E, R) :-
	copy_term(E, Ce),
	substAB(V, Ce, R).
