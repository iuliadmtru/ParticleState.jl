using SparseArrays

"""
Reads the values for the parameters needed in a TaylorParams object from a file and
returns an object of type TaylorParams
"""
function TaylorParamsFromDAT(stream::IOStream)::TaylorParams
    # read the stream up to the line where the needed data is written
    readuntil(stream, "I  COEFFICIENT            ORDER EXPONENTS\r\n", keep = true)
    # sparse matrix that will contain on each column the exponent orders corresponding to each coefficient
    order_exponents = spzeros(UInt8, 6, 0)
    # vector that will contain the coefficients
    coeffs = Float64[]
    while true
        line = readline(stream)
        parts = split(line)
        if length(parts) != 9
            break
        end
        push!(coeffs, parse(Float64, parts[2]))
        order_exponents = hcat(order_exponents, parse.(UInt8, parts[4:9]))
    end
    TaylorParams(order_exponents, coeffs)
end
