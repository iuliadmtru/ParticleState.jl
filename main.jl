include("TParams.jl")
include("TParams-DAT.jl")
include("ParticleState.jl")
include("ParticleStateMapper.jl")

# `ParticleStateMapper` type object constructed using data from the mapsy7.dat file
mapper = ParticleStateMapperFromDAT("Bachelor-project\\mapsy7.dat")

# test serialization and deserialization functions
ParticleStateMapperToJLD2(mapper, "Bachelor-project\\test.jld2")
back = ParticleStateMapperFromJLD2("Bachelor-project\\test.jld2")

# test `evaluate` function with the method from ParticleStateMapper.jl -> vector describing the final state
vars = ParticleState(0.1, 10.0, 0.01, -0.01, 1, 1)
out = evaluate(mapper, vars)
for i in 1:6
    println(fieldnames(ParticleStateMapper)[i], ": ", vars[i], " -> ", out[i])
end

out = evaluate(back, vars)
for i in 1:6
    println(fieldnames(ParticleStateMapper)[i], ": ", vars[i], " -> ", out[i])
end
