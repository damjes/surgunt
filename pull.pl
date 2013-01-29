:- op(950, xfx, <-).

pull(X, X) :-
	X \= (_ <- _).
pull(X, X) :-
	var(X).
pull(N <- P, R) :-
	number(N),
	P =.. [H|T],
	maplist(pull, T, Tv),
	P2 =.. [H|Tv],
	call(P2),
	nth1(N, Tv, R).
