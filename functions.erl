-module(functions).
-compile(export_all).

head([H|_]) -> H.

second([_,S|_]) -> S.

same(X,X) -> true;
same(_,_) -> false.

valid_time({Date={Y,M,D}, Time={H,Min,S}}) ->
	io:format("Date(~p): ~p/~p/~p~n",[Date,Y,M,D]),
	io:format("Time(~p): ~p:~p:~p~n",[Time,H,Min,S]);
valid_time(_) ->
	io:format("Bad time.~n").

driving_age(X) when X >= 16, X =< 104 -> 
	true;
driving_age(_) -> 
	false.

talking_animal(Animal) ->
	Talk = if Animal==cat -> "meow";
		  Animal==cow -> "mooo";
		  Animal==fish -> "blub..blub.";
		  Animal==dog -> "arf";
		  true -> "whatever"
		end,
	{Animal, "says "++Talk++""}.

animal2(cat) -> {"cat says meow"};
animal2(fish) -> {"fish says glug..glug."};
animal2(A) -> {A,"says whatever"}.

animal3(Animal) ->
	case Animal of
		cat -> {"cat says meow"};
		fish -> {"fish says glug..glug"};
		_ -> {Animal," says whatever"}
	end.

rev([H|T]) -> rev(T)++[H];
rev([]) -> [].

last([X]) -> X;
last([_|T]) -> last(T).

pal([]) -> true;
pal([X,X]) -> true;
pal([H|[X,Y]]) -> H=:=Y ,io:format("~p:~p~n",[H,Y]), pal(X);
pal(_) -> false.
