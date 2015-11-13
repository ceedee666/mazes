defmodule Mazes do
	@doc """
	"""
	def generate_using_binary_tree(grid = %Grid{}) do
			generate_using_binary_tree(grid, Grid.all_cell_indices(grid))
	end

  defp generate_using_binary_tree(grid, indices = [h|t]) do
		:random.seed(:os.timestamp)
		
		Grid.neighbors_ne(grid, h) |>
			Enum.random |>
			Grid.link_cells(h, grid) |>
			generate_using_binary_tree(t)													
	end

	defp generate_using_binary_tree(grid, _) do
    grid
	end
	
end
