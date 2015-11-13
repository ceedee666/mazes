defmodule Grid do
	defstruct [:grid, :rows, :cols]
	
	@doc """
    Initializes a new Grid
  """
	def initialize(rows, cols)
	when is_integer(rows) and is_integer(cols) and rows >= 1 and cols >=1 do
		
		%Grid{grid: init_empty_grid(rows, cols), rows: rows, cols: cols}
	end

	@doc """
    Creates an empty grid of size rows * cols
  """
	def init_empty_grid(rows, cols) do
	  init_tuple(fn -> init_tuple(fn -> %{} end, cols) end, rows)
	end

	defp init_tuple(fun, n) do
		Stream.repeatedly(fun)
		|> Enum.take(n)
		|> List.to_tuple
	end

	@doc """
    Returns a list of valid neighbor cell indexes for a grid and a given index
  """
	def neighbors(grid, [r, c]) do
		[[r-1, c], [r+1, c], [r, c-1], [r, c+1]]
		|> Enum.filter(fn([r,c]) ->
			0 <= r and
			r <  grid.rows and
		  0 <= c and
		  c <  grid.cols end)
	end

	@doc """
     Generates a list of all valid cell indexes for a given grid
  """
	def all_cell_indices(grid) do
		for r <- 0..grid.rows-1, c <- 0..grid.cols-1 do [r,c] end
	end
	
end
