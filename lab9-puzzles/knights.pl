% N is size of rows/columns, T is tour taken (as list of positions m(P1,P2))
knightTour(N,T) :- N2 is N*N, % N2 is the number of positions on the board (N^2)
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
    D1>=0,D2>=0,D1<N,D2<N,    % verify next position is within board dimensions
    \+ member(m(D1,D2),Pt),   % next position has not already been covered in tour
    kT(N,N2,[m(D1,D2),m(P1,P2)|Pt],T). % append next position to front of accumulator

% 8 possible moves for a knight
% P1,P2 is knight's position, D1,D2 is knight's destination after one move
% Iterated list solution
moves(m(X,Y), m(U,V)) :-
    member(m(A,B), [m(1,2),m(1,-2),m(-1,2),m(-1,-2),m(2,1),m(2,-1),m(-2,1),m(-2,-1)]),
    U is X + A,
    V is Y + B.