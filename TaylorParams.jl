using SparseArrays, JLD2

"Composite type that holds the parameters of a Taylor expansion"
struct TaylorParams
    "Polynomial degree"
    n::UInt8
    "Matrix containing the exponents of the variables"
    order_exponents::SparseMatrixCSC{UInt8, Int64}
    "Coefficients of the Taylor expansion"
    coeffs::Vector{Float64}
    "Constructor that sets `n` as the maximum value in the exponents matrix"
    function TaylorParams(order_exponents::SparseMatrixCSC{UInt8, Int64}, coeffs::Vector{Float64})
        n = findmax(order_exponents)[1]
        new(n, order_exponents, coeffs)
    end
end

"Evaluates the Taylor expansion described by `params` for the state given by `initial_state`"
function evaluate(params::TaylorParams, initial_state::AbstractVector{Float64})
    # matrix containg the powers of each parameter on each row
    pows = initial_state.^(1:params.n)'
    # vector that will contain the products of the terms corresponding to each coefficient
    prods = ones(size(params.order_exponents)[2])
    for (i, j, val) in zip(findnz(params.order_exponents)...)
        prods[j] *= pows[i, val]
    end
    prods' * params.coeffs
end
