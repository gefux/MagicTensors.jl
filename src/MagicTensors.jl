module MagicTensors

using QuantumClifford
using ITensorMPS

include("abstract_definitions.jl")
""" The magic number. """
const MAGIC = 42

# -- export types --

# -- export functions --
export
    apply!,
    nsites

end
