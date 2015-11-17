defmodule Grid do
	defstruct [:cells, :rows, :cols]
	
	@doc """
    Initializes a new Grid 
  """
	def new(rows, cols)
	  when is_integer(rows) and is_integer(cols) and rows >= 1 and cols >=1 do
		%Grid{cells: init_empty_cells(rows, cols), rows: rows, cols: cols}
	end

  defp init_empty_cells(rows, cols) do
	  for r <- 0..rows-1, c <- 0..cols-1 do [r,c] end |>
		  Enum.reduce(HashDict.new,
				fn i, h ->
					Dict.put(h, i, %{:neighbors => HashSet.new})
				end
			)
	end

	@doc """
     Generates a list of all valid cell indexes for a given grid
  """
	def all_cell_indices(grid) do
		for r <- 0..grid.rows-1, c <- 0..grid.cols-1 do [r,c] end 
	end

	@doc """
    Returns a list of valid neighbor cell indexes for a grid and a given index
  """
	def neighbors(grid, [r, c]) do
		[[r-1, c], [r+1, c], [r, c-1], [r, c+1]] |>
			Enum.filter(
				&is_index_valid?(grid, &1))
	end

	@doc """
    Returns a list of valid neighbor cell indexes to the north or east 
    for a 'grid' and a given 'index'
  """
 	def neighbors_ne(grid, [r,c]) do
		[[r-1,c], [r, c+1]] |>
			Enum.filter(
				&is_index_valid?(grid, &1))
	end

  def is_index_valid?(grid, [r,c]) do
		0 <= r and
		r <  grid.rows and
		0 <= c and
		c <  grid.cols
	end
	
	@doc """
	   Links two cells in the grid
	"""
	def link_cells(target_index,
								 source_index,
								 grid,
								 bidir \\ true) do
		unless Enum.empty?(target_index) do
			cell = Dict.get(grid.cells, source_index)
			cell = Dict.put(cell, :neighbors, Set.put(cell.neighbors, target_index))
			grid = %Grid{grid | cells: HashDict.put(grid.cells, source_index, cell)}

			if bidir do
				grid = link_cells(source_index, target_index, grid, false)
			end
		end
		grid
	end
end
