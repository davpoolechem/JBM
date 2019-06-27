module SM

mutable struct SymMatrix{T} <: AbstractVector{T}
  matrix::Vector{T}

  dim::Int64
end

SymMatrix(dim::Int64) = SymMatrix(Vector(undef,Int64(dim*(dim+1)/2)),dim)
SymMatrix(value,dim::Int64) = SymMatrix(fill(value,Int64(ceil(dim*(dim+1)/2))),dim)
SymMatrix(vector::AbstractVector, dim::Int64) = SymMatrix(vector,dim)


include("SMBasic.jl")
include("SMElements.jl")

#include("BMConstruction.jl")test

end
