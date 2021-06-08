include("TaylorParams.jl")
include("TaylorParams-DAT.jl")
include("ParticleState.jl")
include("ParticleStateMapper.jl")

# `ParticleStateMapper` type object constructed using data from the mapsy7.dat file
mapper = ParticleStateMapperFromDAT("Bachelor-project\\mapsy7.dat")

# test serialization and deserialization functions
ParticleStateMapperToJLD2(mapper, "Bachelor-project\\test.jld2")
back = ParticleStateMapperFromJLD2("Bachelor-project\\test.jld2")

# test `evaluate` function with the method from ParticleStateMapper.jl -> vector describing the final state
initial_state = ParticleState(0.1, 10.0, 0.01, -0.01, 1, 1)
out = evaluate(mapper, initial_state)
for i in 1:6
    println(fieldnames(ParticleStateMapper)[i], ": ", initial_state[i], " -> ", out[i])
end
println("\n")
out = evaluate(back, initial_state)
for i in 1:6
    println(fieldnames(ParticleStateMapper)[i], ": ", initial_state[i], " -> ", out[i])
end
