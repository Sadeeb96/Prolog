
generalreg(ax).
generalreg(bx).

generalreg(cx).
generalreg(dx).
segreg(cs).
segreg(ds).
segreg(ss).
segreg(es).
memloc(word1).
memloc(word2).
memloc(word3).
op1(mov).
op1(cmp).
op2(exchg).
op2(add).
op2(sub).
dest1(Y) :- generalreg(Y) ; segreg(Y) ; memloc(Y).
validtest1(X,Y):- generalreg(X),dest1(Y).


dest2(Y) :- generalreg(Y) ; \+segreg(Y) ; memloc(Y).
validtest2(X,Y):- segreg(X),dest2(Y).
validity1(X,Y):- validtest1(X,Y) ; validtest2(X,Y).
isvalid(X,Y,Z):- op1(X), validity1(Y,Z).