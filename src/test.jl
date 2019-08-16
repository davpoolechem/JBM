function testit_time()
    matrix::Matrix{Float64} = fill(1.0,(10000,10000))
    symmatrix::Sym.SymMatrix{Float64} = Sym.SymMatrix(1.0,10000,true)
    unpacked::Matrix{Float64} = Matrix{Float64}(undef,10000,10000)

    @time Sym.unpack!(symmatrix,unpacked)
    @time unpacked+matrix
    @time Sym.pack!(unpacked,symmatrix)
end

testit_time()
