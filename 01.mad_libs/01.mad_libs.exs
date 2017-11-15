# My first time with Elixir :-)

phrase = "This a ((thing name)). It has ((x:another thing)) inside. And we all love ((x))."

tokens = Regex.scan(~r/\(\((.+?)\)\)/, phrase) |> Enum.map(fn (t) -> List.to_string(tl(t)) end)
sub_tokens = Enum.map tokens, fn (t) ->	s = Regex.split(~r/:/, t); if(length(s) > 1, do:	hd(s)) end

to_ask = tokens -- sub_tokens

answers = List.flatten Enum.map to_ask, fn (q) ->
	a = String.strip IO.gets "Define #{q} =? "
	s = Regex.split(~r/:/, q)
	if length(s) > 1 do
		[{String.to_atom(hd(s)), a}, {String.to_atom(q), a}]
	else
		[{String.to_atom(q), a}]
	end
end

IO.puts Enum.reduce tokens, phrase, fn (t,acc) ->
	String.replace(acc, "((" <> t <> "))", answers[String.to_atom(t)])
end
