import LinearAlgebra

#=======================#
#== general functions ==#
#=======================#

function Base.display(A::SymMatrix{T}) where {T}
  display(A.matrix)
end

#== properties of symmetric matrix ==#
function Base.eltype(A::SymMatrix{T}) where {T}
    return T
end

function Base.length(A::SymMatrix{T}) where {T}
    return length(A.matrix)
end

function Base.ndims(A::SymMatrix{T}) where {T}
    return 2
end

function Base.size(A::SymMatrix{T}) where {T}
    return (A.dim,)
end

function Base.size(A::SymMatrix{T}, i::Int64) where {T}
    return A.dim
end

#== functions for converting storage type ==#
function packed_to_full(A::SymMatrix{T}) where {T}
  B = Matrix{T}(undef,size(A,1),size(A,2))

  ij::Int64 = 0
  for i::Int64 in 1:size(B,1), j::Int64 in 1:i
    ij += 1
    B[i,j] = A[ij]
  end

  ij = 0
  for i::Int64 in 1:size(B,1), j::Int64 in 1:i
    ij += 1
    B[j,i] = A[ij]
  end

  return (A.hermitian == true) ? LinearAlgebra.Hermitian(B) :
    LinearAlgebra.Symmetric(B)
end

function full_to_packed(A::AbstractMatrix{T}) where {T}
  B = SymMatrix(zero(T),size(A,1))

  ij = 0
  for i::Int64 in 1:size(B,1), j::Int64 in 1:i
    ij += 1
    B[ij] = A[i,j]
  end
  return B
end

function full_to_packed(A::LinearAlgebra.Hermitian{T}) where {T}
  B = SymMatrix(zero(T),size(A,1),true)

  ij = 0
  for i::Int64 in 1:size(B,1), j::Int64 in 1:i
    ij += 1
    B[ij] = A[i,j]
  end
  return B
end

#========================#
#== addition functions ==#
#========================#

#== addition with arbitrary abstract matrix class ==#
function Base.:+(A::AbstractMatrix{T}, B::SymMatrix{T}) where {T}
    return A+packed_to_full(B)
end

function Base.:+(A::SymMatrix{T}, B::AbstractMatrix{T}) where {T}
    return B + A
end

#== addition with matrices marked as symmetric ==#
function Base.:+(A::LinearAlgebra.Symmetric{T}, B::SymMatrix{T}) where {T}
    return full_to_packed(LinearAlgebra.Symmetric(A+packed_to_full(B)))
end

function Base.:+(A::SymMatrix{T}, B::LinearAlgebra.Symmetric{T}) where {T}
    return B + A
end

#== addition with matrices marked as symmetric ==#
function Base.:+(A::LinearAlgebra.Hermitian{T}, B::SymMatrix{T}) where {T}
    return full_to_packed(LinearAlgebra.Hermitian(A+packed_to_full(B)))
end

function Base.:+(A::SymMatrix{T}, B::LinearAlgebra.Hermitian{T}) where {T}
    return B + A
end

#== addition of two symmatrices ==#
function Base.:+(A::SymMatrix{T}, B::SymMatrix{T}) where {T}
    return SymMatrix(A.matrix + B.matrix,size(B,1),
      ((A.hermitian == true) && (B.hermitian == true)))
end

#==============================#
#== multiplication functions ==#
#==============================#

#== multiplication with arbitrary abstract matrix class ==#
function Base.:*(A::AbstractMatrix{T}, B::SymMatrix{T}) where {T}
    return A*packed_to_full(B)
end

function Base.:*(A::SymMatrix{T}, B::AbstractMatrix{T}) where {T}
    return B*A
end

#== multiplication with matrices marked as symmetric ==#
function Base.:*(A::LinearAlgebra.Symmetric{T}, B::SymMatrix{T}) where {T}
    return full_to_packed(LinearAlgebra.Symmetric(A*packed_to_full(B)))
end

function Base.:*(A::SymMatrix{T}, B::LinearAlgebra.Symmetric{T}) where {T}
    return B*A
end

#== multiplication with matrices marked as symmetric ==#
function Base.:*(A::LinearAlgebra.Hermitian{T}, B::SymMatrix{T}) where {T}
    return full_to_packed(LinearAlgebra.Hermitian(A*packed_to_full(B)))
end

function Base.:*(A::SymMatrix{T}, B::LinearAlgebra.Hermitian{T}) where {T}
    return B*A
end

#== multiplication of two symmatrices ==#
function Base.:*(A::SymMatrix{T}, B::SymMatrix{T}) where {T}
    return A*packed_to_full(B)
end
