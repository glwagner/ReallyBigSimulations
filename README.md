# ReallyBigSimulations

Demonstrates how to use a [`LocalPreferences.toml`](https://juliapackaging.github.io/Preferences.jl/stable/) (in particular, to use [CUDA's unified memory](https://cuda.juliagpu.org/stable/usage/memory/#Unified-memory) for really big simulations with [Oceananigans](https://github.com/CliMA/Oceananigans.jl)).

Try it by cloning this package (on a machine that has access to a GPU) and then writing

```bash
julia --project this_is_big.jl
```

which produces

```
ReallyBigSimulation$ julia --project this_is_big.jl
(parent(c)).data = GPUArrays.DataRef{CUDA.Mem.DeviceBuffer}(GPUArrays.RefCounted{CUDA.Mem.DeviceBuffer}(DeviceBuffer(216 bytes at 0x0000000602000000), CUDA._free_buffer, Base.Threads.Atomic{Int64}(1)), false)
```

notice the `CUDA.Mem.DeviceBuffer`, which indicates that the memory underlying `c` is device memory.

For example, to get CUDA to allocate unified memory instead, change the `LocalPreferences.toml` from its current setting,

https://github.com/glwagner/ReallyBigSimulations/blob/08a091e4287f915d38b0c6fc47dc071bb0937914/LocalPreferences.toml#L1-L3

to 

```julia
 [CUDA] 
 default_memory = "unified" 
 #default_memory = "device"
```

(You can also delete the line that is commented out.) Re-running our big script then produces

```
```
ReallyBigSimulation$ julia --project this_is_big.jl
(parent(c)).data = GPUArrays.DataRef{CUDA.Mem.UnifiedBuffer}(GPUArrays.RefCounted{CUDA.Mem.UnifiedBuffer}(UnifiedBuffer(216 bytes at 0x00007f3c4a000000), CUDA._free_buffer, Base.Threads.Atomic{Int64}(1)), false)
```

where we can see `CUDA.Mem.UnifiedBuffer` --- as we prefer!
