
# ------------------------------------------------------------------------------------------
# -- Abstract type definitions -------------------------------------------------------------
# ------------------------------------------------------------------------------------------

"""
    AbstractCliffordGate

Interface for generalized few-qubit Clifford gates. These need not be qubit gates, but can also be qudit gates.
Types that implement this interface should be immutable and should implement the following methods:
- `apply!(state::ITensorMPS.MPS, gate::AbstractCliffordGate, sites)`: applies the gate to the given state in-place.
- `apply!(C::AbstractCliffordUnitary, gate::AbstractCliffordGate, sites)`: applies the gate to the given state in-place.
- `nsites(gate::AbstractCliffordGate)`: returns the number of qubits/qudits that the gate acts on.
"""
abstract type AbstractCliffordGate end


"""
    AbstractCliffordGateSet

Interface for an enumerated set of generalized few-qubit Clifford gates.

Types that implement this interface should be immutable and provide:
- `Base.getindex(x::AbstractCliffordGateSet, i)` returns the `i`th gate in the set.
- `Base.length(x::AbstractCliffordGateSet)` returns the number of gates in the set.
- `nsites(gate::AbstractCliffordGateSet)` returns the number of qubits or qudits the gate acts on.
"""
abstract type AbstractCliffordGateSet end


"""
    AbstractPauliSum

Interface for weighted unordered lists of Pauli strings. These can be qubit or qudit Pauli strings.

Types that implement this interface should be immutable and should implement the following methods:
- `Base.length(x::AbstractPauliSum)`: returns the number of qubits/qudits that the Pauli sum acts on.
- `Base.push!(x::AbstractPauliSum, pauli, coeff)`: adds a Pauli string with the given coefficient to the sum.
- `ITensorMPS.MPO(x::AbstractPauliSum)`: converts the Pauli sum to an MPO.    
- `nsites(x::AbstractPauliSum)`: returns the number of Pauli strings in the sum.
 
For some applications, it may also be necessary to implement the following methods:
- `Base.:*(α, x::AbstractPauliSum)`: multiplies the coefficients of the Pauli sum by the given scalar.
- `Base.:*(x::AbstractPauliSum, y::AbstractPauliSum)`: multiplies two Pauli sums together and returns a new Pauli sum.
- `Base.:-(x::AbstractPauliSum)`: negates the coefficients of the Pauli sum and returns a new Pauli sum.
- `Base.:+(x::AbstractPauliSum, y::AbstractPauliSum)`: adds two Pauli sums together and returns a new Pauli sum.
- `Base.:-(x::AbstractPauliSum, y::AbstractPauliSum)`: subtracts one Pauli sum from another and returns a new Pauli sum.
- `LinearAlgebra.adjoint(x::AbstractPauliSum)`: takes the adjoint of the Pauli sum and returns a new Pauli sum.
- `LinearAlgebra.conj(x::AbstractPauliSum)`: takes the complex
- `LinearAlgebra.transpose(x::AbstractPauliSum)`: takes the transpose of the Pauli sum and returns a new Pauli sum.
- `LinearAlgebra.ishermitian(x::AbstractPauliSum)`: returns true if the Pauli sum is Hermitian, and false otherwise.
"""
abstract type AbstractPauliSum end


"""
    AbstractCliffordUnitary 

Interface for Clifford unitaries. These can be qubit or qudit Clifford unitaries.

Types that implement this interface should implement the following methods:
- `apply!(x::AbstractPauliSum, C::AbstractCliffordUnitary)`: applies the Clifford unitary to the given Pauli sum in-place.
- `Base.inv(C::AbstractCliffordUnitary)`: returns the inverse of the Clifford unitary.
- `nsites(C::AbstractCliffordUnitary)`: returns the number of qubits/qudits that the Clifford unitary acts on.
"""
abstract type AbstractCliffordUnitary end


# ------------------------------------------------------------------------------------------
# -- Abstract function definitions ---------------------------------------------------------
# ------------------------------------------------------------------------------------------

"""
    apply!

Applies a Clifford unitary or gate to a matrix product state, another Clifford unitary, or a sum of Pauli strings.
This is a generic function that should be implemented for the concrete types involved.

The following methods should be implemented for the concrete subtypes of `AbstractCliffordGate`, `AbstractCliffordUnitary`, and `AbstractPauliSum`:
- `apply!(state::ITensorMPS.MPS, gate::AbstractCliffordGate, sites)`: applies the gate to the given state in-place.
- `apply!(C::AbstractCliffordUnitary, gate::AbstractCliffordGate, sites)`: applies the gate to the given state in-place.
- `apply!(C::AbstractCliffordUnitary,V::AbstractCliffordUnitary)`: applies the Clifford unitary V to the Clifford unitary C in-place.
- `apply!(x::AbstractPauliSum, C::AbstractCliffordUnitary)`: applies the Clifford unitary to the given Pauli sum in-place.
"""
function apply! end


"""
    nsites

Returns the number of sites in the quantum system.

The following methods should be implemented for the concrete subtypes of `AbstractCliffordGate`, `AbstractCliffordUnitary`, and `AbstractPauliSum`:
- `nsites(gate::AbstractCliffordGate)`: returns the number of qubits/qudits that the gate acts on.
- `nsites(gate_set::AbstractCliffordGateSet)`: returns the number of qubits/qudits that the gates in the set act on.
- `nsites(C::AbstractCliffordUnitary)`: returns the number of qubits/qudits that the Clifford unitary acts on.
- `nsites(x::AbstractPauliSum)`: returns the number of qubits/qudits that the Pauli sum acts on.
"""
function nsites end
