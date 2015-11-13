defmodule AsciiPrinter do
	@doc """
	  Displays a 'grid' using simple ASCII characters
		"""
	def print_grid(grid = %Grid{}) do
		output = "+" <> String.duplicate("---+",grid.cols) <> "\n"
		for r <- 0..grid.rows-1, c <- 0..grid.cols-1 do
		end
	end

end
