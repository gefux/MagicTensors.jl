using MagicTensors
using Test
using JET
using QuantumClifford
using ITensorMPS

@testset "MagicTensors.jl" begin
    @testset "Code Quality" begin
        @testset "Code linting (JET.jl)" begin
            JET.test_package(MagicTensors; target_defined_modules=true)
        end
    end

    # Include specific test files
    include("test_quantum_clifford_qubit.jl")
    include("test_quantum_clifford_util.jl")
end
