import LinearAlgebra

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

    for i::Int64 in 1:size(B,1), j::Int64 in 1:i
        B[i,j] = A[i,j]
        B[j,i] = A[i,j]
    end
    return LinearAlgebra.Symmetric(B)
end

function full_to_packed(A::AbstractMatrix{T}) where {T}
    B = SymMatrix(zero(T),size(A,1))

    for i::Int64 in 1:size(B,1), j::Int64 in 1:i
        #ij::Int64 = (i*(i-1)/2) + j
        B[i,j] = A[i,j]
    end
    return B
end

#== addition with arbitrary abstract matrix class ==#
function Base.:+(A::AbstractMatrix{T}, B::SymMatrix{T}) where {T}
    C = Matrix(undef,size(B,1),size(B,2))

    for i::Int64 in 1:size(C,1), j::Int64 in 1:i
        C[i,j] = A[i,j] + B[i,j]
        if (i != j) C[j,i] = A[j,i] + B[i,j] end
    end
    return C
end

function Base.:+(A::SymMatrix{T}, B::AbstractMatrix{T}) where {T}
    return B + A
end

#== addition with matrices marked as symmetric ==#
function Base.:+(A::LinearAlgebra.Symmetric{T}, B::SymMatrix{T}) where {T}
    C = SymMatrix(zero(T),size(B,1))

    for i::Int64 in 1:size(C,1), j::Int64 in 1:i
        C[i,j] = A[i,j] + B[i,j]
    end
    return C
end

function Base.:+(A::SymMatrix{T}, B::LinearAlgebra.Symmetric{T}) where {T}
    return B + A
end

#== addition with matrices marked as symmetric ==#
function Base.:+(A::LinearAlgebra.Hermitian{T}, B::SymMatrix{T}) where {T}
    C = SymMatrix(zero(T),size(B,1))

    for i::Int64 in 1:size(C,1), j::Int64 in 1:i
        C[i,j] = A[i,j] + B[i,j]
    end
    return C
end

function Base.:+(A::SymMatrix{T}, B::LinearAlgebra.Hermitian{T}) where {T}
    return B + A
end


#== addition of two symmatrices ==#
function Base.:+(A::SymMatrix{T}, B::SymMatrix{T}) where {T}
    return SymMatrix(A.matrix + B.matrix,size(B,1))
end
