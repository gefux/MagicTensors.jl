
# -- QubitPauliSum -------------------------------------------------------------------------

"""
    QubitPauliSum <: AbstractPauliSum

Implementation of `AbstractPauliSum` for qubit systems using the `QuantumClifford` package.
"""
mutable struct QubitPauliSum{Tₛ<:Number, Tₚ<:AbstractVector{<:Unsigned}} <: AbstractPauliSum
    nsites::Int
    paulis::Dict{Tₚ,Tₛ}
end

"""
    QubitPauliSum(nsites::Int)

Constructor for `QubitPauliSum` that initializes an empty (complex) sum for a given number of qubits.
"""
function QubitPauliSum(nsites::Int)
    Tₛ = typeof(1.0 + 1.0im)
    Tₚ = typeof(zero(QuantumClifford.PauliOperator,nsites).xz)
    return QubitPauliSum{Tₛ,Tₚ}(nsites,Dict{Tₛ,Tₚ}())
end

Base.length(x::QubitPauliSum) = length(x.paulis)

function Base.push!(ps::QubitPauliSum, pauli::QuantumClifford.PauliOperator, coeff)
    @assert QuantumClifford.nqubits(pauli) == nsites(ps)
    xz = pauli.xz
    coeff = coeff * _phase_to_number(pauli.phase[1])
    if haskey(ps.paulis, xz)
        ps.paulis[xz] += coeff
    else
        ps.paulis[xz] = coeff
    end
end

nsites(x::QubitPauliSum) = x.nsites

function ITensorMPS.OpSum(ps::QubitPauliSum)
    ops = ITensorMPS.OpSum()
    opNames = ["I", "X", "Y", "Z"]
    N = nsites(ps)

    for (xz, coeff) in ps.paulis
        pauli = QuantumClifford.PauliOperator(0x00, N, xz)
        l = Any[]
        push!(l, coeff)
        for n in 1:N
            num = _int_from_xz(pauli[n]...)
            if num > 0
                push!(l, opNames[num+1])
                push!(l, n)
            end
        end
        if length(l) < 3
            push!(l, opNames[1])
            push!(l, 1)
        end
        add!(ops, l...)
    end
    return ops
end

ITensorMPS.MPO(ps::QubitPauliSum, sites) = ITensorMPS.MPO(ITensorMPS.OpSum(ps), sites)

