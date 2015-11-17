defmodule Mazes do
	@doc """ 
	  Generate a maze for a 'grid' using the binary tree algorithm
	"""
	def generate_using_binary_tree(grid = %Grid{}) do
		:random.seed(:os.timestamp)

		Grid.all_cell_indices(grid) |>
			Enum.reduce(grid, &generate_using_binary_tree(&1, &2))
	end

  defp generate_using_binary_tree(index, grid) do
		Grid.neighbors_ne(grid, index) |>
			Enum.take_random(1) |>
			List.flatten |>
			Grid.link_cells(index, grid)							
	end

end
