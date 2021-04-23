% 9.4 Translation
nounphrase(N, P1, X0, X, P) :-
    determiner(N, P2, P1, X0, X1, P),
    noun(N, X1, X2, P3),
    relclause(N, P3, X2, X, P2).
nounphrase(N, P1, X0, X, P1) :- name(X0, X, N).

determiner(S, P1, P2, [every|X], X, all(S, imply(P1, P2))).
determiner(S, P1, P2, [a|X], X, exists(S, and(P1, P2))).

noun(N, [man|X], X, man(N)).
noun(N, [woman|X], X, woman(N)).
noun(N, [ball|X], X, ball(N)).


name([jacob|X], X, jacob).
name([abby|X], X, abby).

transverb(S, O, [yeets|X], X, yeets(S, O)).
transverb(S, O, [throws|X], X, throws(S, O)).
transverb(S, O, [bops|X], X, bops(S, O)).
intransverb(S, [lives|X], X, lives(S)).

% 9.5 Translation
sentence(X0, X, P) :- nounphrase(N, P1, X0, X1, P),
                        verbphrase(N, X1, X, P1).

verbphrase(S, X0, X, Y) :- transverb(S, O, X0, X1, P1),
                            nounphrase(O, P1, X1, X, Y).
verbphrase(S, X0, X, Y) :- intransverb(S, X0, X, Y).

relclause(S, P1, [who|X1], X, and(P1, P2)) :- verbphrase(S, X1, X, P2).
relclause(S, P1, X, X, P1).

% sentence([a, man, who, throws, abby, yeets, a, man, who, throws, jacob], [], P).
% P = exists(_1676, and(and(man(_1676), throws(_1676, abby)), exists(_1704, and(and(man(_1704), throws(_1704, jacob)), yeets(_1676, _1704)))))

% sentence([every, woman, who, throws, a, ball, yeets, a, man, who, yeets, jacob], [], P).
% P = all(_1682, imply(and(woman(_1682), exists(_1704, and(ball(_1704), throws(_1682, _1704)))), exists(_1726, and(and(man(_1726), throws(_1726, jacob)), yeets(_1682, _1726)))))