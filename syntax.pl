%Genaral Registers
generalreg(ax).
generalreg(bx).
generalreg(cx).
generalreg(dx).

%Segment Registers
segreg(cs).
segreg(ds).
segreg(ss).
segreg(es).

%Memory Locations
memloc(word1).
memloc(word2).
memloc(word3).

%labels
lab(loop).
lab(end).
lab(begin).

%Operator type 1 mov and cmp
op1(mov).
op1(cmp).

%Operator type 1 exchg,add and sub
op2(exchg).
op2(add).
op2(sub).

%checks the first case for move and cmp when source is a general register
dest1(Y) :- generalreg(Y) ; segreg(Y) ; memloc(Y).
validtest1(X,Y):- generalreg(X),dest1(Y).

%checks the second case for mov and cmp when source is a segment register
dest2(Y) :- generalreg(Y) ; \+segreg(Y) ; memloc(Y).
validtest2(X,Y):- segreg(X),dest2(Y).

%checks the third case for mov and cmp when source is a memory location
dest3(Y) :- generalreg(Y) ; segreg(Y) ; \+memloc(Y).
validtest3(X,Y):- memloc(X),dest3(Y).


validity1(X,Y):- validtest1(X,Y) ; validtest2(X,Y) ; validtest3(X,Y).

%final validity check for MOV and CMP
op1validity(X,Y,Z):- op1(X), validity1(Y,Z).

%checks for 1st case of xchg,add,sub when source is general register
dest4(Y):- generalreg(Y) ; memloc(Y).
validtest4(X,Y):- generalreg(X),dest4(Y).

%checks for 1st case of xchg,add,sub when source is general register
dest5(Y):- generalreg(Y) ; \+memloc(Y).
validtest5(X,Y):- memloc(X),dest5(Y).

validity2(X,Y):- validtest4(X,Y) ; validtest5(X,Y).

%final validity check for XCHG,ADD,SUB
op2validity(X,Y,Z):- op2(X), validity2(Y,Z).

jump(jmp).
jump(jg).
jump(jz).



isvalidsyntax(X,Y,Z):- op1validity(X,Y,Z);op2validity(X,Y,Z).
isvalidsyntax(X,Y):- jump(X),lab(Y).



