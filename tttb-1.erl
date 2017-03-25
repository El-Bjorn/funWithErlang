-module(tttb).
-compile(export_all).

% generate an empty board
new_b() -> [e,e,e,e,e,e,e,e,e].

% test a given board for a win state
%            R1  |  R2 |  R3
%           1 2 3|4 5 6|7 8 9     
win([P,P,P,_,_,_,_,_,_]) when P==x; P==o -> P;
win([_,_,_,P,P,P,_,_,_]) when P==x; P==o -> P; 
win([_,_,_,_,_,_,P,P,P]) when P==x; P==o -> P;
win([P,_,_,P,_,_,P,_,_]) when P==x; P==o -> P;
win([_,P,_,_,P,_,_,P,_]) when P==x; P==o -> P;
win([_,_,P,_,_,P,_,_,P]) when P==x; P==o -> P;
win([P,_,_,_,P,_,_,_,P]) when P==x; P==o -> P;
win([_,_,P,_,P,_,P,_,_]) when P==x; P==o -> P;
win([_,_,_,_,_,_,_,_,_]) -> false.

% make a move on a given board
move(P,1,[_|T]) -> [P|T];
move(P,N,[H|T]) -> [H|move(P,N-1,T)]. 

% read in a player's move
read_move(P,B) -> io:format("~p's turn~n",[P]),
		  [R|_]=io:get_chars("enter move: ",2),
		  M=list_to_integer([R]),
		  L=is_legal_move(M,B),
		  read_move_aux(P,B,M,L).

read_move_aux(_,_,M,true) -> M;
read_move_aux(P,B,M,false) -> 
			io:format("~p is an illegal move, try again.~n",[M]),
			read_move(P,B).

% computer player
ai_move(P,B) -> MoveList=legal_moves(B),
		L=length(MoveList),
		R=random:uniform(L),
		lists:nth(R,MoveList).

% test if a given move is legal
is_legal_move(1,[H|_]) -> H=:=e; 
is_legal_move(N,[_|T]) -> is_legal_move(N-1,T). 

% get a list of all legal moves
legal_moves(B) -> legal_moves_aux(B,1).
legal_moves_aux([],10) -> [];
legal_moves_aux([e|T],N) -> [N|legal_moves_aux(T,N+1)]; 
legal_moves_aux([_|T],N) -> legal_moves_aux(T,N+1).

% displaying the board
disp(B) -> io:format("-------~n"),
		disp_aux(B,9).
disp_aux([],0) -> true;
disp_aux([H|T],N) when (N-1) rem 3 =:= 0 ->
			io:format("|~p|~n",[H]), 
			io:format("-------~n"),
			disp_aux(T,N-1);
disp_aux([H|T],N) -> io:format("|~p",[H]), disp_aux(T,N-1).

% two person play
play() -> B=new_b(), play_aux(B,x).

switch_player(x) -> o;
switch_player(o) -> x.

play_aux(B,P) -> disp(B),
	case win(B) of
		x -> io:format("x wins~n");
		o -> io:format("o wins~n");
		false -> M = read_move(P,B),
			NewB = move(P,M,B),
			NewP = switch_player(P),
			play_aux(NewB,NewP)
	end.
