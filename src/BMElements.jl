import Base.getindex
import Base.setindex!

function Base.getindex(A::BlockMatrix{T}, i::Int64, j::Int64) where {T}
    row::Int64 = ceil(i/A.block_dims[1])
    col::Int64 = ceil(j/A.block_dims[2])
    ii::Int64 = (i-1)%A.block_dims[1] + 1
    jj::Int64 = (j-1)%A.block_dims[2] + 1

    return A.matrix[row,col][ii,jj]
end

function block(A::BlockMatrix{T}, i::Int64, j::Int64) where {T}
    return A.matrix[i,j]
end

#function Base.setindex!(A::BlockMatrix{T}, x::AbstractMatrix{T}, i::Int64, j::Int64) where {T}
#    row::Int64 = ceil(i/A.block_dims[1])
#    col::Int64 = ceil(j/A.block_dims[2])
#    ii::Int64 = (i-1)%A.block_dims[1] + 1
#    jj::Int64 = (j-1)%A.block_dims[2] + 1

#    A.matrix[row,col][ii,jj] = x[i,j]
#    return A.matrix[row,col][ii,jj]
#end
