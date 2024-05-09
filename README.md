# ReallyBigSimulations

Demonstrates how to use a LocalPreferences.toml (in particular, to use CUDA's unified memory for really big simulations with Oceananigans).

Try it by cloning this package (on a machine that has access to a GPU) and then writing

```bash
julia --project this_is_big.jl
```

For example, to get CUDA to allocate unified memory, change the `LocalPreferences.toml` from its current setting,

https://github.com/glwagner/ReallyBigSimulations/blob/08a091e4287f915d38b0c6fc47dc071bb0937914/LocalPreferences.toml#L1-L3

to 

```julia
 [CUDA] 
 default_memory = "unified" 
 #default_memory = "device"
```

(You can also delete the line that is commented out.)
