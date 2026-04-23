"""
Tests for QubitPauliSum and related functionality in stabilizer_qubit.jl
"""

@testset "QubitPauliSum" begin
    @testset "Construction" begin
        # Test creating an empty QubitPauliSum with different sizes
        ps1 = MagicTensors.QubitPauliSum(1)
        @test MagicTensors.nsites(ps1) == 1
        
        ps4 = MagicTensors.QubitPauliSum(4)
        @test MagicTensors.nsites(ps4) == 4
        
        # Test that paulis dictionary is initially empty
        @test length(ps4.paulis) == 0
    end

    @testset "Adding Pauli operators" begin
        ps = MagicTensors.QubitPauliSum(3)
        
        MagicTensors.push!(ps, QuantumClifford.P"XYZ", 0.1)
        @test length(ps) == 1

        MagicTensors.push!(ps, QuantumClifford.P"X__", 0.2)
        @test length(ps) == 2

        MagicTensors.push!(ps, QuantumClifford.P"XYZ", 0.3im-0.3)
        @test length(ps) == 2 # the same operator is updated, not added again

        @test_throws AssertionError MagicTensors.push!(ps, QuantumClifford.P"XX", 0.1) # wrong number of qubits
    end

    @testset "MPO conversion" begin
        ps = MagicTensors.QubitPauliSum(3)
        MagicTensors.push!(ps, QuantumClifford.P"___", 0.3)
        MagicTensors.push!(ps, QuantumClifford.P"X__", 0.3+0.2im)
        MagicTensors.push!(ps, QuantumClifford.P"X_Z", 0.2im)

        # Convert to MPO
        sites = ITensorMPS.siteinds("Qubit", 3)
        mpo = ITensorMPS.MPO(ps, sites)
        @test isa(mpo, ITensorMPS.MPO)
    end
end
