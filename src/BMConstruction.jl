#form block matrix from input matrix and block dimensions
function bmfill(number::T,mdims_elementwise::Tuple{Int64,Int64},
        input_block_dims::Tuple{Int64,Int64}) where {T}
    #check that input dimensions divide input matrix size
    #@assert matrix_size[1]%input_block_dims[1] = 0
    #@assert matrix_size[2]%input_block_dims[2] = 0

    #determine block matrix dimensions
    block_matrix_rows::Int64 = floor(mdims_elementwise[1]/input_block_dims[1])
    block_matrix_cols::Int64 = floor(mdims_elementwise[2]/input_block_dims[2])

    block_matrix_temp = Matrix{Matrix{T}}(undef, (block_matrix_rows,block_matrix_cols))
    for irow in 1:block_matrix_rows, icol in 1:block_matrix_cols
        block_matrix_temp[irow,icol] = fill(number, input_block_dims)
    end

    block_matrix = BlockMatrix(block_matrix_temp,input_block_dims)
    return block_matrix
end

#form block matrix from input matrix and block dimensions
function bmzeros(T::DataType, matrix_size::Tuple{Int64,Int64},
        input_block_dims::Tuple{Int64,Int64})
    block_matrix = bmfill(zero(T),matrix_size,input_block_dims)
    return block_matrix
end

#form block matrix from input matrix and block dimensions
function bmones(T::DataType, matrix_size::Tuple{Int64,Int64},
        input_block_dims::Tuple{Int64,Int64})
    block_matrix = bmfill(oneunit(T),matrix_size,input_block_dims)
    return block_matrix
end

#form block matrix from input matrix and block dimensions
function bmrand(number::T,mdims_elementwise::Tuple{Int64,Int64},
        input_block_dims::Tuple{Int64,Int64}) where {T}
    #check that input dimensions divide input matrix size
    #@assert matrix_size[1]%input_block_dims[1] = 0
    #@assert matrix_size[2]%input_block_dims[2] = 0

    #determine block matrix dimensions
    block_matrix_rows::Int64 = floor(mdims_elementwise[1]/input_block_dims[1])
    block_matrix_cols::Int64 = floor(mdims_elementwise[2]/input_block_dims[2])

    block_matrix_temp = Matrix{Matrix{T}}(undef, (block_matrix_rows,block_matrix_cols))
    for irow in 1:block_matrix_rows, icol in 1:block_matrix_cols
        block_matrix_temp[irow,icol] = rand(T, input_block_dims)
    end

    block_matrix = BlockMatrix(block_matrix_temp,input_block_dims)
    return block_matrix
end
