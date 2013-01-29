compose(X, [], X).
compose(X, [P|Cp], Z) :-
	copy_term(P, Pc),
	Pc =.. L,
	append(L, [X, Y], L2),
	P2 =.. L2,
	call(P2),
	compose(Y, Cp, Z).
