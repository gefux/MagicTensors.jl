using MagicTensors
using Test
using JET

@testset "MagicTensors.jl" begin
    @testset "Code linting (JET.jl)" begin
        JET.test_package(MagicTensors; target_defined_modules = true)
    end
    @testset "check wizarding skills" begin
        @test MagicTensors.MAGIC == 42
    end
end
