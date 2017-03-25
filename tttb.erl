-module(tttb).
-compile(export_all).

%            R1  |  R2 |  R3
%           1 2 3|4 5 6|7 8 9     
new_b() -> [e,e,e,e,e,e,e,e,e].
win([P,P,P,_,_,_,_,_,_]) when P==x; P==o -> P;
win([_,_,_,P,P,P,_,_,_]) when P==x; P==o -> P; 
win([_,_,_,_,_,_,P,P,P]) when P==x; P==o -> P;
win([P,_,_,P,_,_,P,_,_]) when P==x; P==o -> P;
win([_,P,_,_,P,_,_,P,_]) when P==x; P==o -> P;
win([_,_,P,_,_,P,_,_,P]) when P==x; P==o -> P;
win([P,_,_,_,P,_,_,_,P]) when P==x; P==o -> P;
win([_,_,P,_,P,_,P,_,_]) when P==x; P==o -> P;
win([_,_,_,_,_,_,_,_,_]) -> false.

move(P,1,[_|T]) -> [P|T];
move(P,N,[H|T]) -> [H|move(P,N-1,T)]. 

is_legal_move(1,[H|_]) -> H==e; 
is_legal_move(N,[_|T]) -> is_legal_move(N-1,T). 

legal_moves(B) -> legal_moves_aux(B,1).

legal_moves_aux([],10) -> [];
legal_moves_aux([e|T],N) -> [N|legal_moves_aux(T,N+1)]; 
legal_moves_aux([_|T],N) -> legal_moves_aux(T,N+1).


disp(B) -> io:format("-------~n"),
		disp_aux(B,9).

disp_aux([],0) -> true;
disp_aux([H|T],N) when (N-1) rem 3 =:= 0 ->
			io:format("|~p|~n",[H]), 
			io:format("-------~n"),
			disp_aux(T,N-1);
disp_aux([H|T],N) -> io:format("|~p",[H]), disp_aux(T,N-1).

