import Base.getindex
import Base.setindex!

function Base.getindex(A::SymMatrix{T}, i::Int64, j::Int64) where {T}
    ij::Int64 = (i > j) ? (i*(i-1)/2) + j : (j*(j-1)/2) + i

    return A.matrix[ij]
end

function Base.getindex(A:: SymMatrix{T}, i::Int64) where {T}
    return A.matrix[i]
end

function Base.setindex!(A::SymMatrix{T}, x::T, i::Int64, j::Int64) where {T}
    ij::Int64 = (i > j) ? (i*(i-1)/2) + j : (j*(j-1)/2) + i

    A.matrix[ij] = x
    return A.matrix[ij]
end

function Base.setindex!(A::SymMatrix{T}, x::T, i::Int64) where {T}
    A.matrix[i] = x
    return A.matrix[i]
end
