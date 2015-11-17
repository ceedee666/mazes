defmodule AsciiMazePrinter do
	@doc """
	  Displays a 'grid' using simple ASCII characters
		"""
	def print_grid(grid = %Grid{}) do
		top = "+" <> String.duplicate("---+",grid.cols) <> "\n"
		
		rl = for r <- 0..grid.rows-1 do
			ml = for c <- 0..grid.cols-1 do
				if c == 0 do
					m = "|   "
				else
					m = "   "
				end

				cell = HashDict.get(grid.cells, [r,c])

				if Set.member?(cell[:neighbors], [r,c+1]) do
					m = m <> " "
				else
					m = m <> "|"
				end
				m
			end

			bl = for c <- 0..grid.cols-1 do
				if c == 0 do
					b = "+"
				else
					b = ""
				end

				cell = HashDict.get(grid.cells, [r,c])

				if Set.member?(cell[:neighbors], [r+1,c]) do
					b = b <> "   +"
				else
					b = b <> "---+"
				end
				b
			end

			s = Enum.reduce(ml, fn s, acc -> acc <> s end) <> "\n"
			s = s <> Enum.reduce(bl, fn s, acc -> acc <> s end) <> "\n"
		end
		IO.puts(top <> Enum.reduce(rl, fn s, acc -> acc <> s end))
	end
end
