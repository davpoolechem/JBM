module JulBM

mutable struct BlockMatrix{T} <: AbstractArray{T,2}
    matrix::Matrix{Matrix{T}}

    mdims_blockwise::Tuple{Int64,Int64}
    block_dims::Tuple{Int64,Int64}

    mdims_elementwise::Tuple{Int64,Int64}
end

BlockMatrix(matrix,block_dims) = BlockMatrix(matrix,
                                                (size(matrix)[1],size(matrix)[2]),
                                                block_dims,
                                                (size(matrix)[1]*block_dims[1],
                                                 size(matrix)[2]*block_dims[2])
                                            )
BlockMatrix() = BlockMatrix([[]], (1,1), (1,1), (1,1))

include("BMBasic.jl")
include("BMConstruction.jl")
include("BMElements.jl")

end
