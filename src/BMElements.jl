import Base.getindex
import Base.+

function getindex(A::BlockMatrix{T}, i::Int64, j::Int64) where {T}
    row::Int64 = ceil(i/A.block_dims[1])
    col::Int64 = ceil(j/A.block_dims[2])
    ii::Int64 = (i-1)%A.block_dims[1] + 1
    jj::Int64 = (j-1)%A.block_dims[2] + 1

    return A.matrix[row,col][ii,jj]
end

function getblock(A::BlockMatrix{T}, i::Int64, j::Int64) where {T}
    return A.matrix[i,j]
end

function +(x::BlockMatrix{Number}, y::BlockMatrix{Number})
    for i in 1:x.mdims_blockwise[1], j in x.mdims_blockwise[2]
        x[i,j] += y[i,j]
    end
    return x
end