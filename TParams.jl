using SparseArrays, JLD2

"Composite type that holds the parameters of a Taylor expansion"
struct TParams
    "Polynomial degree"
    n::UInt8
    "Matrix containing the exponents of the variables"
    order_exponents::SparseMatrixCSC{UInt8, Int64}
    "Coefficients of the Taylor expansion"
    coeffs::Vector{Float64}
    "Constructor that sets `n` as the maximum value in the exponents matrix"
    function TParams(order_exponents::SparseMatrixCSC{UInt8, Int64}, coeffs::Vector{Float64})
        n = findmax(order_exponents)[1]
        new(n, order_exponents, coeffs)
    end
end

"Evaluates the Taylor expansion described by `params` for the state given by `initial_state`"
function evaluate(params::TParams, initial_state::Vector{Float64})
    # matrix containg the powers of each parameter on each row
    pows = initial_state.^(1:params.n)'
    # vector that will contain the products of the terms corresponding to each coefficient
    prods = ones(size(params.order_exponents)[2])
    for (i, j, val) in zip(findnz(params.order_exponents)...)
        prods[j] *= pows[i, val]
    end
    prods' * params.coeffs
end

"""
Serializes the data needed to map the initial state of a particle to the final state,
contained in an object `tparams` of type Vector{TParams} into a file 'filename'
"""
function TParamsToJLD2(tparams::Vector{TParams}, filename::AbstractString)
    save_object(filename, tparams)
end

"Deserializes `filename` to get the mapping data"
function TParamsFromJLD2(filename::AbstractString)::Vector{TParams}
    load_object(filename)
end