defmodule Mazes do
	@doc """ 
	  Generate a maze for a 'grid' using the binary tree algorithm
	"""
	def generate_using_binary_tree(grid = %Grid{}) do
		:random.seed(:os.timestamp)

		generate_using_binary_tree(grid, Grid.all_cell_indices(grid))
	end

  defp generate_using_binary_tree(grid, [h|t]) do
		random_neighbor =
			Grid.neighbors_ne(grid, h) |>
			Enum.take_random(1) |>
			List.flatten
		
		Grid.link_cells(grid, h, random_neighbor) |>
			generate_using_binary_tree(t)													
	end

	defp generate_using_binary_tree(grid, _) do
    grid
	end
end
