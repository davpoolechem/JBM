#form block matrix from input matrix and block dimensions
function eltype(A::BlockMatrix{T}) where {T}
    return T
end

function length(A::BlockMatrix{T}) where {T}
    length = A.mdims_blockwise[1]*A.mdims_blockwise[2]
    length *= A.block_dims[1]*A.block_dims[2]
    return length
end

function ndims(A::BlockMatrix{T}) where {T}
    return 2
end

function size_blockwise(A::BlockMatrix{T}) where {T}
    return A.mdims_blockwise
end

function size_elementwise(A::BlockMatrix{T}) where {T}
    return A.mdims_elementwise
end

function size_elementwise(A::BlockMatrix{T}, n::Int64) where {T}
    return (A.mdims_elementwise)[n]
end
