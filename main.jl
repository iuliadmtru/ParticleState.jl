include("TParams.jl")
include("TParams-DAT.jl")
include("Mapping.jl")

# `Mapping` type object constructed using data from the mapsy7.dat file
mapping = MappingFromDAT("Bachelor-project\\mapsy7.dat")

# test serialization and deserialization functions
MappingToJLD2(mapping, "Bachelor-project\\test.jld2")
MappingFromJLD2("Bachelor-project\\test.jld2")

# test `evaluate` function with the method from Mapping.jl -> vector describing the final state
vars = [0.1, 10.0, 0.01, -0.01, 1, 1]
map = evaluate(mapping, vars)
for i in 1:length(vars)
    println(fieldnames(Mapping)[i], ": ", vars[i], " -> ", map[i])
end
