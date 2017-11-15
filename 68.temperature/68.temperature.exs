# Ruby Quiz #68: http://rubyquiz.com/quiz68.html (Elixir lang. version)
# Created as MIX application with httpotion and ibrowse deps
# Use 'mix' command to build and run with "httpotion"

# My assumption: the app is started by e.g. "mix compile London imperial"
[_, location, units] = cond do
	length(System.argv) == 3 ->
		System.argv
	length(System.argv) == 2 ->
		System.argv ++ ["metric"]
	true ->
		[nil, "Krakow", "metric"]
end

token = "494ae42daa10248e805514c015b9020d"
url = "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{token}&units=#{units}"

HTTPotion.start
res = HTTPotion.get(url)

temperature = hd Regex.run(~r/temp":(.+?),/, res.body, capture: :all_but_first)
location = hd Regex.run(~r/name":"(.+?)",/, res.body, capture: :all_but_first)
degrees_type = (if units=="metric", do: "C", else: "F")
IO.puts "The temperature in #{location} is #{temperature} degrees #{degrees_type}"
