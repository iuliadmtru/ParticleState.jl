using StaticArrays

"Composite type that holds the parameters describing the mapping from one particle state to another"
struct ParticleStateMapper <: FieldVector{6, TaylorParams}
    x::TaylorParams
    u::TaylorParams
    y::TaylorParams
    v::TaylorParams
    τ::TaylorParams
    dK_K0::TaylorParams
end

"Constructs a `ParticleStateMapper` type object from the data given by the function `TaylorParamsFromDAT`"
function ParticleStateMapperFromDAT(filename::AbstractString)::ParticleStateMapper
    stream = open(filename)
    mappers = TaylorParams[]
    for _ in 1:6
        push!(mappers, TaylorParamsFromDAT(stream))
    end
    close(stream)
    ParticleStateMapper(mappers...)
end

"""
Evaluates the Taylor expansions described by the fields of `mapping` for the state given by
`initial_state` and stores the results in a vector
"""
function evaluate(mapper::ParticleStateMapper, state::ParticleState)::ParticleState
    evaluate.(mapper, Ref(state))
end

"""
Serializes the data needed to map the initial state of a particle to the final state,
contained in an object `mapper` of type `ParticleStateMapper`` into a file 'filename'
"""
function ParticleStateMapperToJLD2(mapper::ParticleStateMapper, filename::AbstractString)
    save_object(filename, mapper)
end

"Deserializes `filename` to get the mapping data"
function ParticleStateMapperFromJLD2(filename::AbstractString)::ParticleStateMapper
    load_object(filename)
end
