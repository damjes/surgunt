anonPred(Gp, Gd, Cx) :-
	copy_term([Gp|Gd], [Cp, Cx]),
	call(Cp).
anonPred(Gp, Gd, Cx, Cy) :-
	copy_term([Gp|Gd], [Cp, Cx, Cy]),
	call(Cp).
anonPred(Gp, Gd, Cx, Cy, Cz) :-
	copy_term([Gp|Gd], [Cp, Cx, Cy, Cz]),
	call(Cp).
