module MagicTensors

using QuantumClifford
using ITensorMPS

include("abstract_definitions.jl")
include("quantum_clifford_util.jl")
include("quantum_clifford_qubit.jl")

# -- export types --
export
    QubitPauliSum

# -- export functions --
export
    apply!,
    nsites

end
