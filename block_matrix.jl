module JulBM

mutable struct BlockMatrix{T<:Number}
    matrix::Matrix{Matrix{T}}
    block_dims::Tuple{Int64,Int64}
end

#form block matrix from input matrix and block dimensions
BlockMatrix(input_matrix::Matrix{T},input_block_dims::Tuple{Int64,Int64}) where {T<:Number}
    #check that input dimensions divide input matrix size
    @assert size(matrix)[1]%input_block_dims[1] = 0
    @assert size(matrix)[2]%input_block_dims[2] = 0

    #determine block matrix dimensions
    block_matrix_rows = size(matrix)[1]/input_block_dims[1]
    block_matrix_cols = size(matrix)[2]/input_block_dims[2]

    for irow in 1:block_matrix_rows, icol in 1:block_matrix_cols
        matrix_rows = irow*input_block_dims[1]:((irow+1)*input_block_dims[1]-1)
        matrix_cols = icol*input_block_dims[2]:((icol+1)*input_block_dims[2]-1)
        matrix[irow,icol] = matrix[matrix_rows,matrix_cols]
    end
end

getindex()
end

end
