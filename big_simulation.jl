using Oceananigans

grid = RectilinearGrid(GPU(), size=(1, 1, 1), extent=(1, 1, 1))
c = CenterField(grid)
@show parent(c)

