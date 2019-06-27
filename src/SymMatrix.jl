module Sym

#== SymMatrix structure ==#
mutable struct SymMatrix{T} <: AbstractVector{T}
  matrix::Vector{T}

  dim::Int64
  hermitian::Bool
end

#== empty matrix ==#
SymMatrix() = SymMatrix([],0,0)

#== uninitialized matrix with given dimensions ==#
SymMatrix(dim::Int64) = SymMatrix(Vector(undef,Int64(dim*(dim+1)/2)),
  dim,0)

SymMatrix(dim::Int64, hermitian::Bool) = SymMatrix(Vector(undef,
  Int64(dim*(dim+1)/2)),dim,hermitian)

#== matrix initialized to a certain value ==#
SymMatrix(value,dim::Int64) = SymMatrix(fill(value,Int64(dim*(dim+1)/2)),
  dim,0)

SymMatrix(value,dim::Int64) = SymMatrix(fill(value,Int64(dim*(dim+1)/2)),
  dim,hermitian)

#== matrix initialized by an input vector ==#
SymMatrix(vector::AbstractVector, dim::Int64) = SymMatrix(vector,
  dim,0)

SymMatrix(vector::AbstractVector, dim::Int64) = SymMatrix(vector,
  dim,hermitian)

#== includes ==#
include("SymBasic.jl")
include("SymElements.jl")

#include("BMConstruction.jl")test

end
