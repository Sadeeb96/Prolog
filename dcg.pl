%List Predicates
member(X,[X|_]).
member(X,[_|T]):-member(X,T).
append([],L,L).
append(A,B,C):- [H|T] = A, [H|T1]= C, append(T,B,T1).

append3(Xs, Ys, Zs, XsYsZs) :- append(Xs, YsZs, XsYsZs),append(Ys, Zs, YsZs).

isOp1([X]):-member(X,[mov,cmp]).
isOp2([X]):-member(X,[xchg,add,sub]).
isJump([X]):-member(X,[jg,jmp, jnz]).
isLabel([X]):-member(X,[begin,end,loop]).
isGen([X]):-member(X,[ax,bx,cx,dx]).
isSeg([X]):-member(X,[cs,ds,ss,es]).
isMemloc([X]):-member(X,[word1,word2,word3]).
isCorrect(L):- isOp1(A),isGen(B),isGen(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isSeg(B),isGen(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isMemloc(B),isGen(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isMemloc(B),isSeg(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isGen(B),isSeg(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isGen(B),isMemloc(C),append3(A,B,C,L).
isCorrect(L):- isOp1(A),isSeg(B),isMemloc(C),append3(A,B,C,L).
isCorrect(L):-isOp2(A),isGen(B),isGen(C),append3(A,B,C,L).
isCorrect(L):-isOp2(A),isMemloc(B),isGen(C),append3(A,B,C,L).
isCorrect(L):-isOp2(A),isGen(B),isMemloc(C),append3(A,B,C,L).
isCorrect(L):-isJump(A),isLabel(B),append(A,B,L).

