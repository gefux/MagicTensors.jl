"""
Tests for utility functions in util_quantum_clifford.jl
"""

@testset "Utility Functions" begin
    @testset "_phase_to_number" begin
        # Test phase to complex number conversion
        @test MagicTensors._phase_to_number(0x00) == 1.0
        @test MagicTensors._phase_to_number(0x01) == 0.0 + 1.0im
        @test MagicTensors._phase_to_number(0x02) == -1.0
        @test MagicTensors._phase_to_number(0x03) == 0.0 - 1.0im
        
        # Test that results are correct type
        @test isa(MagicTensors._phase_to_number(0x00), Real)
        @test isa(MagicTensors._phase_to_number(0x01), Complex)
    end

    @testset "_int_from_xz" begin
        # Test encoding of Pauli operators
        @test MagicTensors._int_from_xz(false, false) == 0  # I (identity)
        @test MagicTensors._int_from_xz(true, false) == 1   # X
        @test MagicTensors._int_from_xz(true, true) == 2    # Y
        @test MagicTensors._int_from_xz(false, true) == 3   # Z
        
        # Verify all combinations
        combinations = [
            (false, false, 0),
            (true, false, 1),
            (true, true, 2),
            (false, true, 3),
        ]
        for (x, z, expected) in combinations
            @test MagicTensors._int_from_xz(x, z) == expected
        end
    end
end
