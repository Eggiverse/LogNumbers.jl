using LogNumbers
using Test

@testset "LogNumber.jl" begin
    a = LogNumber(exp(1))
    @test a.sign == 1 
    @test a.exponent ≈ 1
    a = LogNumber(-exp(1))
    @test a.sign == -1
    @test a.exponent ≈ 1

end

const test_pairs = (
    (0.99, 0.876),
    (10.99, 0.01),
    (-0.98, 0.87),
    (0.88,-0.99),
    (-1.88, -0.98)
)

@testset "+" begin
    for (x, y) in test_pairs
        a = LogNumber(x)
        b = LogNumber(y)
        @test a+b isa LogNumber
        @test to_number(a+b) ≈ x + y
    end
end

@testset "-" begin
    for (x, y) in test_pairs
        a = LogNumber(x)
        b = LogNumber(y)
        @test a-b isa LogNumber
        @test to_number(a-b) ≈ x - y
    end
end

@testset "*" begin
    for (x, y) in test_pairs
        a = LogNumber(x)
        b = LogNumber(y)
        @test a*b isa LogNumber
        @test to_number(a*b) ≈ x * y
    end
end

@testset "/" begin
    for (x, y) in test_pairs
        a = LogNumber(x)
        b = LogNumber(y)
        @test a/b isa LogNumber
        @test to_number(a/b) ≈ x / y
    end
end
