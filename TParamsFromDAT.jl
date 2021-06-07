using SparseArrays

"""
Reads the values for the parameters needed in a TParams object from a file and
returns an object of type TParams
"""
function TParamsFromDAT(stream::IOStream)::Union{TParams, Nothing}
    # read the stream up to the line where the needed data is written
    readuntil(stream, "I  COEFFICIENT            ORDER EXPONENTS\r\n", keep = true)
    # check if the stream is at the end-of-file
    if eof(stream)
        return nothing
    end
    # vector that will contain each line with data from one dataset
    lines = String[]
    current_line = readline(stream)
    # stop adding elements to the `lines` vector when the current line doesn't contain data anymore
    while length(split(current_line)) == 9
        push!(lines, current_line)
        current_line = readline(stream)
    end
    # sparse matrix that will contain on each column the exponent orders corresponding to each coefficient
    order_exponents = spzeros(UInt8, 6, length(lines))
    # vector that will contain the coefficients
    coeffs = Float64[]
    # 6-element vector that will contain each set of exponent orders
    v = UInt8[]
    for i in 1:length(lines)
        push!(coeffs, parse(Float64, split(lines[i])[2]))
        for order in 4:length(split(lines[i]))
            push!(v, parse(UInt8, split(lines[i])[order]))
        end
        order_exponents[:, i] = v
        v = UInt8[]
    end
    TParams(order_exponents, coeffs)
end
