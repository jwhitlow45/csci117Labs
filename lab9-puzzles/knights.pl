% N is size of rows/columns, T is tour taken (as list of positions m(P1,P2))
knightTour(N, M, T) :- N2 is N*M, % N2 is the number of positions on the board (N^2)
    kT(N,N2,[m(0,0)],T). % [m(0,0)] is starting position of the knight

% kT(N,N2,[m(P1,P2)|Pt],T)
% N is the row/column size
% N2 is the number of positions on the board
% [m(P1,P2)|Pt] is the accumulator for the tour
%   m(P1,P2) is the current position of the knight
%   Pt (partial tour) is the list of previous positions of the knight 
% T is the full tour

% Finished: Length of tour is equal to size of board
% return accumulator as tour
kT(N,N2,T,T) :- length(T,N2). 

kT(N,N2,[m(P1,P2)|Pt],T) :- 
    moves(m(P1,P2),m(D1,D2)), % get next position from current position
    D1>=0,D2>=0,D1<N,D2<(N2/N),    % verify next position is within board dimensions
    \+ member(m(D1,D2),Pt),   % next position has not already been covered in tour
    kT(N,N2,[m(D1,D2),m(P1,P2)|Pt],T). % append next position to front of accumulator

% 8 possible moves for a knight
% P1,P2 is knight's position, D1,D2 is knight's destination after one move
% Iterated list solution
moves(m(X,Y), m(U,V)) :-
    member(m(A,B), [m(1,2),m(1,-2),m(-1,2),m(-1,-2),m(2,1),m(2,-1),m(-2,1),m(-2,-1)]),
    U is X + A,
    V is Y + B.

closedKnightsTour(N, M, T) :- knightTour(N, M, T),	% check if a given solution is a closed knights tour
    							closed(T).

closed([H|T]) :- help(H, T).	% check if first and last moves are within a move of each other
help(H, [T]) :- moves(H, T).	% base case: check if first and last move are within a move
help(P, [H|T]) :- help(P, T).	% recursive case: iterate through moves list

% knightTour(5, 5, X).
% X = [m(0, 4), m(2, 3), m(4, 4), m(3, 2), m(4, 0), m(2, 1), m(0, 2), m(1, 4), m(3, 3), m(4, 1), m(2, 0), m(0, 1), m(1, 3), m(3, 4), m(4, 2), m(3, 0), m(1, 1), m(0, 3), m(2, 2), m(1, 0), m(3, 1), m(4, 3), m(2, 4), m(1, 2), m(0, 0)]

% closedKnightsTour(3, 10, X).
% X = [m(2, 1), m(0, 2), m(1, 0), m(2, 2), m(1, 4), m(0, 6), m(1, 8), m(2, 6), m(0, 5), m(2, 4), m(0, 3), m(1, 1), m(2, 3), m(1, 5), m(0, 7), m(1, 9), m(2, 7), m(0, 8), m(2, 9), m(1, 7), m(0, 9), m(2, 8), m(1, 6), m(0, 4), m(2, 5), m(1, 3), m(0, 1), m(2, 0), m(1, 2), m(0, 0)]