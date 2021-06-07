struct Mapping
    xmap::TParams
    umap::TParams
    ymap::TParams
    vmap::TParams
    τmap::TParams
    dKmap::TParams
end

function evaluate(mapping::Mapping, initial_state::Vector{Float64})
    [
        evaluate(mapping.xmap, initial_state),
        evaluate(mapping.umap, initial_state),
        evaluate(mapping.ymap, initial_state),
        evaluate(mapping.vmap, initial_state),
        evaluate(mapping.τmap, initial_state),
        evaluate(mapping.dKmap, initial_state)
    ]
end

# struct Mapping
#     state_map::Vector{TParams}
# end

# function taylormap(mapping::Mapping, initial_state::Vector{Float64})
#     evaluate.(mapping, Ref(initial_state))
# end
