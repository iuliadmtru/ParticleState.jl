"Composite type that holds the parameters describing the mapping from one particle state to another"
struct Mapping
    xmap::TParams
    umap::TParams
    ymap::TParams
    vmap::TParams
    τmap::TParams
    dKmap::TParams
end

"""
Evaluates the Taylor expansions described by the fields of `mapping` for the state given by
`initial_state` and stores the results in a vector
"""
function evaluate(mapping::Mapping, initial_state::Vector{Float64})::Vector{Float64}
    [
        evaluate(mapping.xmap, initial_state),
        evaluate(mapping.umap, initial_state),
        evaluate(mapping.ymap, initial_state),
        evaluate(mapping.vmap, initial_state),
        evaluate(mapping.τmap, initial_state),
        evaluate(mapping.dKmap, initial_state)
    ]
end
