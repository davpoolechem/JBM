#form block matrix from input matrix and block dimensions
function Base.eltype(A::BlockMatrix{T}) where {T}
    return T
end

function Base.length(A::BlockMatrix{T}) where {T}
    length = A.mdims_blockwise[1]*A.mdims_blockwise[2]
    length *= A.block_dims[1]*A.block_dims[2]
    return length
end

function Base.ndims(A::BlockMatrix{T}) where {T}
    return 2
end

function size_blockwise(A::BlockMatrix{T}) where {T}
    return A.mdims_blockwise
end

function Base.size(A::BlockMatrix{T}) where {T}
    return A.mdims_elementwise
end

function Base.:+(A::BlockMatrix{T}, B::AbstractMatrix{T}) where {T}
    for i in 1:A.mdims_elementwise[1], j in 1:A.mdims_elementwise[2]
        row::Int64 = ceil(i/A.block_dims[1])
        col::Int64 = ceil(j/A.block_dims[2])
        ii::Int64 = (i-1)%A.block_dims[1] + 1
        jj::Int64 = (j-1)%A.block_dims[2] + 1

        A[rows,cols][ii,jj] += B[i,j]
    end
    return A
end

#optimize addition between two block matrices
function Base.:+(A::BlockMatrix{T}, B::BlockMatrix{T}) where {T}
    for i in 1:A.mdims_blockwise[1], j in 1:A.mdims_blockwise[2]
        A.matrix[i,j] += B.matrix[i,j]
    end
    return A
end
