include("TParams.jl")
include("Mapping.jl")
include("TParams-DAT.jl")

# stream that contains the information from the mapsy7.dat file
io = open("Bachelor-project\\mapsy7.dat")

# vector that will contain `TParams` objects constructed from each dataset in the given file
current_tparam = TParamsFromDAT(io)
tparams = TParams[]
while current_tparam !== nothing
    push!(tparams, current_tparam)
    current_tparam = TParamsFromDAT(io)
end

close(io)

# test serialization and deserialization functions
TParamsToJLD2(tparams, "Bachelor-project\\test.jld2")
TParamsFromJLD2("Bachelor-project\\test.jld2")

# test `evaluate` function with the method from Mapping.jl -> vector describing the final state
vars = [6.0, 5, 4, 3, 2, 1]
mapping = Mapping(tparams...)
@timev evaluate(mapping, vars)
