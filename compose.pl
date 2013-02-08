compose(X, [], X).
compose(X, [P|Ps], Z) :-
	call(P, X, Y),
	compose(Y, Ps, Z).
