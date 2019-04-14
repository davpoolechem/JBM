using JulBM

function testit_block(A::JulBM.BlockMatrix{T}) where {T<:Number}
    A+A
end

function testit_norm(A::Array{T,2}) where {T<:Number}
    A+A
end

function testit_time()
    test::JulBM.BlockMatrix{Int32} = JulBM.bmones(Int32,(16000,32000),(320,320))
    @time testit_block(test)

    test2::Array{Int32,2} = ones(Int32,(16000,16000))
    @time testit_norm(test2)
end

testit_time()
