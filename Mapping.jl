"Composite type that holds the parameters describing the mapping from one particle state to another"
struct Mapping
    xmap::TParams
    umap::TParams
    ymap::TParams
    vmap::TParams
    τmap::TParams
    dKmap::TParams
end

"Constructs a `Mapping` type object from the data given by the function `TParamsFromDAT`"
function MappingFromDAT(filename::AbstractString)::Mapping
    io = open(filename)
    tparams = TParams[]
    for _ in 1:6
        push!(tparams, TParamsFromDAT(io))
    end
    close(io)
    Mapping(tparams...)
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

"""
Serializes the data needed to map the initial state of a particle to the final state,
contained in an object `mapping` of type Mapping into a file 'filename'
"""
function MappingToJLD2(mapping::Mapping, filename::AbstractString)
    save_object(filename, mapping)
end

"Deserializes `filename` to get the mapping data"
function MappingFromJLD2(filename::AbstractString)::Mapping
    load_object(filename)
end
