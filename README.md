What is surgunt
===============

Surgunt is a simple Prolog library written by matma6 under M6PL.

What is inside
==============

Inside we have four files (plus surgunt.pl, which loads those files).

anonFun
-------

The `anonFun` file provides interface to compute functions. It support `do/1`
syntax, because Prolog has no evaluation. Let's look at example, function,
which adds two numbers (in curried form):

    F = (X -> Y -> do(Z is X+Y) -> Z)

Brackets are necessary, because operator `->` has higher priority than `=`.
This function is usable using `subst/3` predicate. Examples:

    subst([2,3], F, R)

`2` is substituted, so we have `Y -> do(Z is 2+Y) -> Z`, then `3` is substituted
giving `do(Z is 2+3) -> Z`. Now library detects `do/1` syntax and calls code
inside the brackets. Result is `5`.

    subst([1], F, Incr)

We get `Incr = (Y -> do(Z is 1+Y) -> Z)` function. It increments argument.
Later, we can use it, using `subst([X], Incr, Y)`.

anonPred
--------

The `anonPred` file provides `anonPred/[3-5]` predicates, which can be used to
putting inline predicates, i.e. when we have 3x3 matrix, we wrote:

    length_(X, L) :- length(L, X).
    ?- length(Rows, 3), maplist(length_(3), Rows).

Now, defining `length_/2` isn't neccesary, because we can use anonymous
predicates. Our predicate is `anonPred/3`:

    anonPred(Code, Interface, FirstArg)
    % or more precisely
    anonPred(length(L, 3), [L], List)

Interface is used to bind arguments to variables into piece of code.
Now we can say:

    maplist(anonPred(length(L, 3), [L]), Rows)

Then Prolog gets every row in Rows list and concatenate with predicate, so
we get:

    anonPred(length(L, 3), [L], Row)

for each row.

Another example is computing something using formula. I.e. we will compute
sum of n first integers (starting from 1). Data are on the list, so we can
write only:

    maplist(anonPred(R is (N * (N+1))/2, [N, R]), Ns, Rs)

compose
-------

The `compose/3` predicate is F#-inspired operation. When we transform object
using many predicates, we could write:

    p1(Input, X1),
    p2(X1, X2),
    p3(X2, Output)

Now, we can write:

    compose(Input, [p1, p2, p3], Output)

When you write `p1(a, b, c)`, it transforms to: `p1(a, b, c, InputN, OutN)`.
The maplist do it in the same way!

pull
----

The `pull/2` predicate enables constructing compound formulas, which is
impossible in pure Prolog, because of no evaluation.

We could compute nth Fibonacci number using:

    N1 is N-1,
    N2 is N-2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1+F2

Now, we can do it using:

    pull(1 <- _ is (2 <- fib(1 <- _ is N-1, _)) + (2 <- fib(1 <- _ is N-2, _)), F)

or more clear:

    pull(1 <- _ is +(
        2 <- fib(1 <- _ is N-1, _),
        2 <- fib(1 <- _ is N-2, _)),
    F)
