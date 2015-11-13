defmodule Grid do
	defstruct [:cells, :rows, :cols]
	
	@doc """
    Initializes a new Grid 
  """
	def initialize(rows, cols)
	  when is_integer(rows) and is_integer(cols) and rows >= 1 and cols >=1 do
		
		%Grid{cells: init_empty_grid(rows, cols), rows: rows, cols: cols}
	end

  defp init_empty_grid(rows, cols) do
	  init_tuple(
			fn -> init_tuple(
        fn -> %{:neighbors => HashSet.new} end,
        cols) end,
			rows)
	end

	defp init_tuple(fun, n) do
		Stream.repeatedly(fun)
		|> Enum.take(n)
		|> List.to_tuple
	end

	@doc """
	  Updates the `grid' cell specified by the `index` with the 
    new `cell` value
  """
	def put_cell(index = [r,c], cell, grid) do
		new_grid_row = elem(grid.cells, r) |> put_elem(c, cell)		
		%Grid{grid | cells: put_elem(grid.cells, r, new_grid_row)}
	end
	
	
	@doc """
    Returns a list of valid neighbor cell indexes for a grid and a given index
  """
	def neighbors([r, c], grid) do
		[[r-1, c], [r+1, c], [r, c-1], [r, c+1]]
		|> Enum.filter(fn([r,c]) ->
			0 <= r and
			r <  grid.rows and
		  0 <= c and
		  c <  grid.cols end)
	end

	@doc """
    Returns a list of valid neighbor cell indexes to the north or east 
    for a 'grid' and a given 'index'
  """
	def neighbors_ne(grid, index = [index_r,index_c]) do
		neighbors(index, grid) |>
			Enum.filter(fn([r|c]) -> index_r <= r and
			                         index_c <= c end)
	end

	@doc """
     Generates a list of all valid cell indexes for a given grid
  """
	def all_cell_indices(grid) do
		for r <- 0..grid.rows-1, c <- 0..grid.cols-1 do [r,c] end 
	end

	@doc """
	   Links two cells in the grid
	"""
	def link_cells(source_cell_index = [sr,sc],
								 target_cell_index,
								 grid,
								 bidir \\ true) do
		cell = elem(grid.cells, sr) |> elem(sc) 
	  cell = %{cell | :neighbors => HashSet.put(cell.neighbors, target_cell_index)}
	  grid = put_cell(source_cell_index, cell, grid)

		if bidir do
			 grid = link_cells(target_cell_index, source_cell_index, grid, false)
		end

		grid
	end
end
