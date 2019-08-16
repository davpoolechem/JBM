module Sym

#== SymMatrix structure ==#
mutable struct SymMatrix{T} <: AbstractVector{T}
  matrix::Vector{T} #triangular array representing symmetric matrix
  dim::Int64 #matrix dimension
  hermitian::Bool #whether matrix is hermitian or not

  #SymMatrix{T}(matrix::Vector{T},dim::Int64,hermitian::Bool) where {T} =
  #  length(matrix) == Int64(dim*(dim+1)/2) ?
  #  new(matrix,dim,hermitian) :
  #  error("Matrix size does not match value implied by input dimension")
end

#== empty matrix ==#
SymMatrix() = SymMatrix([],0,false)

#== uninitialized matrix with given dimensions ==#
SymMatrix(dim::Int64) = SymMatrix(Vector(undef,Int64(dim*(dim+1)/2)),
  dim,false)

SymMatrix(dim::Int64, hermitian::Bool) = SymMatrix(Vector(undef,
  Int64(dim*(dim+1)/2)),dim,hermitian)

#== matrix initialized to a certain value ==#
SymMatrix(value, dim::Int64) = SymMatrix(fill(value,Int64(dim*(dim+1)/2)),
  dim,false)

SymMatrix(value, dim::Int64, hermitian::Bool) = SymMatrix(fill(value,
  Int64(dim*(dim+1)/2)),dim,hermitian)

#== matrix initialized by an input vector ==#
SymMatrix(vector::AbstractVector, dim::Int64) = SymMatrix(vector,
  dim,false)

SymMatrix(vector::AbstractVector, dim::Int64, hermitian::Bool) = SymMatrix(
  vector,dim,hermitian)

#== includes ==#
include("SymBasic.jl")
include("SymElements.jl")

#include("BMConstruction.jl")test

end
