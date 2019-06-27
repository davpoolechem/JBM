using Sym

function testit_block(A::JulBM.BlockMatrix{T}) where {T<:Number}
    A+A
end

function testit_norm(A::Array{T,2}) where {T<:Number}
    A+A
end

function testit_time()
    matrix::Matrix{Int64} = fill(0,(10000,10000))
    symmatrix::Sym.SymMatrix{Int64} = Sym.SymMatrix(0,10000,10000)

    #@time testit_block(test)

    #test2::Array{Int32,2} = ones(Int32,(16000,16000))
    #@time testit_norm(test2)
end

testit_time()
