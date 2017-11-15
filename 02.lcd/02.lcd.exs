defmodule LCD do 
	import Enum, only: [map: 2, zip: 2] 
	import Tuple, only: [to_list: 1] 
	import List, only: [flatten: 1] 
	
	def string_to_lcd(string, size \\ 2) do 
	  String.codepoints(string) 
		|> map(fn(digit) -> to_lcd_char(tl(tl(Integer.digits(code(String.to_integer(digit))+256,2))),size)	end) 
		|> mzip 
	end 
	
	def mzip([one]), do: one 
	def mzip(list) when is_list(list), do: rows_zip(list) |> map &(flatten(&1)) 
	defp rows_zip([first, last]), do: zip(first, last) |> map( &(to_list(&1)) ) 
	defp rows_zip([head | tail]), do: zip(head,rows_zip(tail)) |> map(&(to_list(&1)))  
	
	defp to_lcd_char([e1,e2,e3,e4,e5,e6,e7], size) do 
		[g1,g3,g6]    = map [e1,e3,e6],    fn(x) -> if(x==1, do: '-', else: ' ') end 
		[g2,g4,g5,g7] = map [e2,e4,e5,e7], fn(x) -> if(x==1, do: '|', else: ' ') end 
		
		[r1,r2,r3,r4,r5] = ( 
			[[' ',g1,' '],[g2,' ',g4],[' ',g3,' '],[g5,' ',g7],[' ',g6,' ']] 
			|> map fn([a,b,c]) -> flatten [a, multiply(b,size), c, ' '] end 
		) 
		
		[r1] ++  multiply(r2, size) ++ [r3] ++ multiply(r4, size) ++ [r5] 
	end 
	
	def multiply(e,1), do: [e] 
	def multiply(e,n), do: [e] ++ multiply(e,n-1) 
	
	defp code(n) when is_integer(n) and n >= 0 and n <=9 do 
		elem({111, 9, 94, 91, 57, 115, 119, 73, 127, 123}, n) 
	end 
end 

cond do 
	length(System.argv) == 1 -> 
		System.argv	|> List.last |> LCD.string_to_lcd	|> Enum.each &(IO.puts &1) 
	length(System.argv) == 3 -> 
		[_,size,digits] =	System.argv 
		LCD.string_to_lcd(digits,String.to_integer(size))	|> Enum.each &(IO.puts &1)
	true ->
		"12345" |> LCD.string_to_lcd	|> Enum.each &(IO.puts &1) 
end
