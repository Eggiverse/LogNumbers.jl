module LogNumbers
using Base

export LogNumber, to_number

struct LogNumber{T}
    sign::Int8
    exponent::T
end
LogNumber(s, e) = LogNumber(Int8(s), e)

LogNumber(x) = LogNumber(sign(x), log(abs(x)))
to_number(x::LogNumber) = x.sign*exp(x.exponent)

Base.sign(x::LogNumber) = x.sign

function mul_div(pm::Union{typeof(+), typeof(-)}, x::LogNumber{T1}, y::LogNumber{T2}) where {T1, T2}
    if x.sign == 0 || y.sign == 0
        return LogNumber(0, oneunit(promote_type(T1, T2)))
    end
    LogNumber(x.sign*y.sign, pm(x.exponent, y.exponent))
end

Base.:(*)(x::LogNumber, y::LogNumber) = mul_div(+, x, y)
Base.:(*)(x::LogNumber, y) = x*LogNumber(y)
Base.:(*)(x, y::LogNumber) = LogNumber(x)*y

Base.:(/)(x::LogNumber, y::LogNumber) = mul_div(-, x, y)
Base.:(/)(x::LogNumber, y) = x/LogNumber(y)
Base.:(/)(x, y::LogNumber) = LogNumber(x)/y

function ordered_plus(x::LogNumber, y::LogNumber)
    (x.sign*exp(x.exponent-y.exponent)+y.sign) * abs(y)
end
Base.:(+)(x::LogNumber, y::LogNumber) = x.exponent > y.exponent ? ordered_plus(y, x) : ordered_plus(x, y)
Base.:(+)(x, y::LogNumber) = LogNumber(x) + y
Base.:(+)(x::LogNumber, y) = x + LogNumber(y)

Base.:(-)(x::LogNumber) = LogNumber(-x.sign, x.exponent)
Base.:(-)(x::LogNumber, y::LogNumber) = x + (-y)
Base.:(-)(x, y::LogNumber) = x + (-y)
Base.:(-)(x::LogNumber, y) = x + (-y)

Base.abs(x::LogNumber) = LogNumber(1, x.exponent)

Base.sqrt(x::LogNumber) = LogNumber(sqrt(x.sign), x.exponent/2)

Base.:(^)(x::LogNumber, n) = LogNumber(x.sign^n, x.exponent*n)

end
