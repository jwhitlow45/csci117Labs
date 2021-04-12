--------PART 1--------

deal([], [], []).
deal([H|T1], S, [H|T2]) :- deal(S, T1, T2).

deal([1,3],[2,4],[1,2,3,4])     mode + + +
true

deal(X,[2,4],[1,2,3,4])         mode - + +
X = [1, 3]

deal([1,3],X,[1,2,3,4])         mode + - +
X = [2, 4]

deal([1,3],[2,4],X)             mode + + -
X = [1, 2, 3, 4]

deal(X,Y,[1,2,3,4])             mode - - +
X = [1, 3],
Y = [2, 4]



merge([], [], []).
merge([], [H|T], [H|T]).
merge([H|T], [], [H|T]).
merge([H1|T1], [H2|T2], [H1|T]) :- merge(T1, [H2|T2], T), (H1 =< H2).
merge([H1|T1], [H2|T2], [H2|T]) :- merge([H1|T1], T2, T), (H2 < H1).

% merge([1,2],[3,4], [1,2,3,4]) mode + + +
% true

% merge(X,[3,4], [1,2,3,4])     mode - + +
% X = [1, 2]

% merge([1,2],Y, [1,2,3,4])     mode + - +
% Y = [3, 4]

% merge(X,Y, [1,2,3,4])         mode - - +
% X = [],
% Y = [1, 2, 3, 4]
% X = [1, 2, 3, 4],
% Y = []
% X = [1],
% Y = [2, 3, 4]
% X = [1, 2],
% Y = [3, 4]
% X = [1, 2, 3],
% Y = [4]
% X = [1, 2, 4],
% Y = [3]
% X = [1, 3, 4],
% Y = [2]
% X = [1, 3],
% Y = [2, 4]
% X = [1, 4],
% Y = [2, 3]
% X = [2, 3, 4],
% Y = [1]
% X = [2],
% Y = [1, 3, 4]
% X = [2, 3],
% Y = [1, 4]
% X = [2, 4],
% Y = [1, 3]
% X = [3, 4],
% Y = [1, 2]
% X = [3],
% Y = [1, 2, 4]
% X = [4],
% Y = [1, 2, 3]

% merge([1,2],[3,4],X)        mode + + -
% X = [1, 2, 3, 4]



ms([], []).
ms([H], [H]).
ms([H|T], S) :- deal(L1, R1, [H|T]),
    			ms(L1, L2),
    			ms(R1, R2),
    			merge(L2, R2, S).

% ms([2,1,3],[1,2,3])       mode + +
% true

% ms([2,1,3],X)             mode + -
% X = [1, 2, 3]

% mode - + times out

--------PART 2--------

cons(E, nil, snoc(nil,E)).
cons(E, snoc(BL,N), snoc(EBL,N)) :- cons(E, BL, EBL).

% cons(5, snoc(snoc(nil,3),4), X)                               mode + + -
% X = snoc(snoc(snoc(nil, 5), 3), 4)
% cons(5, snoc(snoc(nil,3),4), snoc(snoc(snoc(nil, 5), 3), 4))  mode + + +
% true
% cons(X, Y, snoc(snoc(snoc(nil, 5), 3), 4))
% X = 5,
% Y = snoc(snoc(nil, 3), 4)
% cons(X, snoc(snoc(nil,3),4), snoc(snoc(snoc(nil, 5), 3), 4))
% X = 5
% cons(5, Y, snoc(snoc(snoc(nil, 5), 3), 4))
% Y = snoc(snoc(nil, 3), 4)



toBList([], nil).
toBList([H|T], S) :- toBList(T, E), cons(H, E, S).

% toBList([1,2,3],X)                                mode + -
% X = snoc(snoc(snoc(nil, 1), 2), 3)

% toBList([1,2,3],snoc(snoc(snoc(nil, 1), 2), 3))   mode + +
% true

% toBList(X,snoc(snoc(snoc(nil, 1), 2), 3))         mode - +
% X = [1, 2, 3]



snoc(E, [], [E]).
snoc(E, [H|T], [H|S]) :- snoc(E, T, S).

% snoc(4, [1,2,3], X)           mode + + -
% X = [1, 2, 3, 4]

% snoc(4, [1,2,3], [1,2,3,4])   mode + + +
% true

% snoc(X, [1,2,3], [1,2,3,4])   mode - + +
% X = 4

% snoc(X, Y, [1,2,3,4])         mode - - +
% X = 4,
% Y = [1, 2, 3]     

% snoc(4, Y, [1,2,3,4])         mode + - +
% Y = [1, 2, 3]



fromBList(nil, []).
fromBList(snoc(BL, N), S) :- fromBList(BL, L), snoc(N, L, S).

% fromBList(snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4), Y).              mode + -
% Y = [1, 2, 3, 4]

% fromBList(snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4), [1, 2, 3, 4]).   mode + +
% true

% fromBList(X, [1, 2, 3, 4]).
% X = snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4)                         mode - +



num_empties(empty, 1).
num_empties(node(Root, L, R), S) :- num_empties(L, S1), num_empties(R, S2), S is S1 + S2.

% num_empties(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), X)    mode + -
% X = 6

% num_empties(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), 6)    mode + +
% true

% num_empties(X, 2)                                                                                             mode - +
% X = node(_1574, empty, empty)
% this timed out when looking for other possibilities



num_nodes(empty, 0).
num_nodes(node(Root, L, R), S) :- num_nodes(L, S1), num_nodes(R, S2), S is S1 + S2 + 1.

% num_nodes(node(12, empty, node(12, empty, empty)), X)     mode + -
% X = 2

% num_nodes(node(12, empty, node(12, empty, empty)), 2)     mode + +
% true

% num_nodes(X, 2)                                           mode - +
% X = node(_1574, empty, node(_1582, empty, empty))
% this timed out when looking for other possibilities



insert_left(empty, S, node(S, empty, empty)).
insert_left(node(Root, L, R), S, node(Root, NL, R)) :- insert_left(L, S, NL).

% insert_left(node(12, empty, node(2, empty, empty)), 10, L)                                                        mode + + -
% L = node(12, node(10, empty, empty), node(2, empty, empty))
% insert_left(node(12, empty, node(2, empty, empty)), 10, node(12, node(10, empty, empty), node(2, empty, empty)))  mode + + +
% true

% insert_left(node(12, empty, node(2, empty, empty)), X, node(12, node(10, empty, empty), node(2, empty, empty)))   mode + - +
% X = 10

% insert_left(X, 10, node(12, node(10, empty, empty), node(2, empty, empty)))                                       mode - + +
% X = node(12, empty, node(2, empty, empty))

% insert_left(X, Y, node(12, node(10, empty, empty), node(2, empty, empty)))                                        mode - - +
% X = node(12, empty, node(2, empty, empty)),
% Y = 10



insert_right(empty, S, node(S, empty, empty)).
insert_right(node(Root, L, R), S, node(Root, L, NR)) :- insert_right(R, S, NR).

% insert_right(node(12, empty, node(2, empty, empty)), 10, R)                                                       mode + + -
% R = node(12, empty, node(2, empty, node(10, empty, empty)))
% insert_right(node(12, empty, node(2, empty, empty)), 10, node(12, empty, node(2, empty, node(10, empty, empty)))) mode + + +
% true
% insert_right(node(12, empty, node(2, empty, empty)), X, node(12, empty, node(2, empty, node(10, empty, empty))))  mode + - +
% X = 10
% insert_right(X, 10, node(12, empty, node(2, empty, node(10, empty, empty))))                                      mode - + +
% X = node(12, empty, node(2, empty, empty))
% insert_right(X, Y, node(12, empty, node(2, empty, node(10, empty, empty))))                                       mode - - -
% X = node(12, empty, node(2, empty, empty)),
% Y = 10



sum_nodes(empty, 0).
sum_nodes(node(Root, L, R), S) :- sum_nodes(L, S1), sum_nodes(R, S2), S is S1 + S2 + Root.

% sum_nodes(node(12, empty, node(2, empty, node(10, empty, empty))), S)     mode + -
% S = 24

% sum_nodes(node(12, empty, node(2, empty, node(10, empty, empty))), 24)    mode + +
% true
% does not work with mode - +



inorder(empty, []).
inorder(node(Root, L, R), S) :-  inorder(R, S2), inorder(L, S1), append(S1, [Root|S2], S).

% inorder(node(12, node(10, empty, empty), node(2, empty, empty)), S)               mode + -
% S = [10, 12, 2]

% inorder(node(12, node(10, empty, empty), node(2, empty, empty)), [10, 12, 2])     mode + +
% true

% inorder(X, [10, 12, 2])                                                           mode - +
% X = node(2, node(12, node(10, empty, empty), empty), empty)



num_elts(leaf(E), 1).
num_elts(node(Root, L, R), S) :- num_elts(L, S1), num_elts(R, S2), S is S1 + S2 + 1.

% num_elts(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), X)    mode + -
% X = 7

% num_elts(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), 7)    mode + +
% true

% num_elts(X, 7)                                                                    mode - +
% X = node(_1574, leaf(_1582), node(_1586, leaf(_1594), node(_1598, leaf(_1606), leaf(_1610))))
% this timed out when looking for other possibilities



sum_nodes2(leaf(E), E).
sum_nodes2(node(Root, L, R), S) :- sum_nodes2(L, S1), sum_nodes2(R, S2), S is S1 + S2 + Root.

% sum_nodes2(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), X)      mode + -
% X = 97

% sum_nodes2(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), 97)     mode + +
% true

% sum_nodes2(X, 97)                                                                     mode - +
% X = leaf(97)
% this timed out when looking for other possibilities



inorder2(leaf(E), [E]).
inorder2(node(Root, L, R), S) :- inorder2(R, S2), inorder2(L, S1), append(S1, [Root|S2], S).

% inorder2(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), X)                            mode + -
% X = [0, 10, 2, 12, 20, 2, 51]

% inorder2(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), [0, 10, 2, 12, 20, 2, 51])    mode + +
% true

% inorder2(X, [0, 10, 2, 12, 20, 2, 51])                                                                    mode - +
% X = node(2, node(12, node(10, leaf(0), leaf(2)), leaf(20)), leaf(51))
% this timed out when looking for other possibilities



conv21(leaf(E), node(E, empty, empty)).
conv21(node(Root, L , R), node(Root, S1, S2)) :- conv21(L, S1), conv21(R, S2).

% conv21(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), X)
% mode + -
% X = node(12, node(10, node(0, empty, empty), node(2, empty, empty)), node(2, node(20, empty, empty), node(51, empty, empty)))

% conv21(node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51))), node(12, node(10, node(0, empty, empty), node(2, empty, empty)), node(2, node(20, empty, empty), node(51, empty, empty))))
% mode + +
% true

% conv21(X, node(12, node(10, node(0, empty, empty), node(2, empty, empty)), node(2, node(20, empty, empty), node(51, empty, empty))))
% mode - +
% X = node(12, node(10, leaf(0), leaf(2)), node(2, leaf(20), leaf(51)))



toBList([], nil).
toBList(L, S) :- toBListIt(L, nil, S).
toBListIt([], R, R).
toBListIt([H|T], BL, S) :- toBListIt(T, snoc(BL, H), S).

% toBList([1,2,3,4], X)                                         mode + -
% X = snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4)

% toBList([1,2,3,4], snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4))   mode + +
% true

% toBList(X, snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4))           mode - +
% X = [1, 2, 3, 4]



fromBList(nil, []).
fromBList(BL, S) :- fromBListIt(BL, [], S).
fromBListIt(nil, R, R).
fromBListIt(snoc(BL, N), AL, S) :- fromBListIt(BL, [N|AL], S).

% fromBList(X, [1,2,3,4])                                       mode - +
% X = snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4)

% fromBList(snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4), [1,2,3,4]) mode + +
% true

% fromBList(snoc(snoc(snoc(snoc(nil, 1), 2), 3), 4), X)         mode + -
% X = [1, 2, 3, 4]



num_empties(empty, 0).
num_empties(N, S) :- num_emptiesIt([N], 0, S).
num_emptiesIt([], AC, AC).
num_emptiesIt([empty|T], AC, S) :- X is AC + 1, num_emptiesIt(T, X, S).
num_emptiesIt([node(Root, L, R)|T], AC, S) :- num_emptiesIt([L|[R|T]], AC, S).

% num_empties(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), X)        mode + -
% X = 6

% num_empties(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), 6)        mode + +
% true

% num_empties(X, 6)                                                                                                 mode - +
% X = node(_1574, empty, node(_1582, empty, node(_1590, empty, node(_1598, empty, node(_1606, empty, empty)))))
% this timed out when looking for other possibilities



num_nodes(empty, 0).
num_nodes(N, S) :- num_nodesIt([N], 0, S).
num_nodesIt([], AC, AC).
num_nodesIt([empty|T], AC, S) :- num_nodesIt(T, AC, S).
num_nodesIt([node(Root, L, R)|T], AC, S) :- X is AC + 1, num_nodesIt([L|[R|T]], X, S).

% num_nodes(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), X)          mode + -
% X = 5

% num_nodes(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), 5)          mode + +
% true

% num_nodes(X, 5)                                                                                                   mode - +
% X = node(_1574, empty, node(_1582, empty, node(_1590, empty, node(_1598, empty, node(_1606, empty, empty)))))


sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

% sum_nodes_it(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), X)       mode + -
% X = 149

% sum_nodes_it(node(12, node(42, node(32, node(51, empty, empty), empty), node(12, empty, empty)), empty), 149)     mode + +
% true
% mode - + does not work for this function



sum_nodes2_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([leaf(E)|Ts], A, N) :- X is A + E, sum_help(Ts, X, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

% sum_nodes2_it(node(12, node(42, node(32, leaf(51), leaf(2)), leaf(12)), leaf(10)), X)     mode + -
% X = 161

% sum_nodes2_it(node(12, node(42, node(32, leaf(51), leaf(2)), leaf(12)), leaf(10)), 161)   mode + +
% true



inorder2It(T, N) :- inorder2ItHelp([T], [], N).
inorder2ItHelp([], A, A).
inorder2ItHelp([leaf(E)|T], A, S) :- inorder2ItHelp(T, [E|A], S).
inorder2ItHelp([node(Root, L, R)|T], A, S) :- inorder2ItHelp([R|[leaf(Root)|[L|T]]], A, S).

% inorder2It(node(12, node(42, node(32, leaf(51), leaf(2)), leaf(12)), leaf(10)), X)                                mode + -
% X = [51, 32, 2, 42, 12, 12, 10]

% inorder2It(node(12, node(42, node(32, leaf(51), leaf(2)), leaf(12)), leaf(10)), [51, 32, 2, 42, 12, 12, 10])      mode + +
% true

% inorder2It(X, [51, 32, 2, 42, 12, 12, 10])                                                                        mode - +
% X = node(12, node(42, node(32, leaf(51), leaf(2)), leaf(12)), leaf(10))



--------PART 4--------

conv12(T1, T2) :- build(T1, T2).
build(node(Root, empty, empty), leaf(Root)).
build(node(Root, L, R), node(Root, NL, NR)) :- build(L, NL), build(R, NR).

% conv12(node(12, node(42, node(32, empty, empty), node(12, empty, empty)), node(13, empty, empty)), X)
% X = node(12, node(42, leaf(32), leaf(12)), leaf(13))
% mode + -

% conv12(node(12, node(42, node(32, empty, empty), node(12, empty, empty)), node(13, empty, empty)), node(12, node(42, leaf(32), leaf(12)), leaf(13)))
% true
% mode + +

% conv12(X, node(12, node(42, leaf(32), leaf(12)), leaf(13)))
% X = node(12, node(42, node(32, empty, empty), node(12, empty, empty)), node(13, empty, empty))
% mode - +



posinf(posinf).
neginf(neginf).

comp(A, B) :- neginf(A).
comp(A, B) :- posinf(B).
comp(A, B) :- number(A), number(B), (A < B).

bst(T, true) :- bst(T).
bst(T, false).
bst(T) :- bsthelp(T, neginf, posinf).
bsthelp(empty, LL, UL).
bsthelp(node(A, L, R), LL, UL) :- comp(A, UL), comp(LL, A), bsthelp(L, LL, A), bsthelp(R, A, UL).

% bst(node(6, node(4, empty, node(5, empty, empty)), node(10, node(7, empty, empty), empty)), L)    mode + -
% L = true

% bst(node(6, node(4, empty, node(25, empty, empty)), node(10, node(7, empty, empty), empty)), L)   mode + -
% L = false

% bst(X, true)                                                                                      mode - +
% X = empty

% bst(node(6, node(4, empty, node(5, empty, empty)), node(10, node(7, empty, empty), empty)), true) mode + +
% true



posinf(posinf).
neginf(neginf).

comp(A, B) :- neginf(A).
comp(A, B) :- posinf(B).
comp(A, B) :- number(A), number(B), (A < B).

bst(T, true) :- bst(T).
bst(T, false).
bst(T) :- bsthelp(T, neginf, posinf).
bsthelp(leaf(E), LL, UL) :- comp(LL, E), comp(E, UL).
bsthelp(node(A, L, R), LL, UL) :- comp(A, UL), comp(LL, A), bsthelp(L, LL, A), bsthelp(R, A, UL).

% bst(node(6, leaf(4), node(10, leaf(7), leaf(11))), true)  mode + +
% true

% bst(node(6, leaf(4), node(10, leaf(7), leaf(11))), X)     mode + -
% X = true

% bst(node(6, leaf(41), node(10, leaf(7), leaf(11))), X)    mode + -
% X = false

% bst(X, true)                                              mode - + 
% X = leaf(neginf)