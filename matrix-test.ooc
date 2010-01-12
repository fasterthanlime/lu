import Matrix

main: func {
    
    m := Matrix identity(3)
    m[1, 1] = 5
    
    "m = " println()
    m print()
    
    "m[2, 2] is %.2f" format(m[2, 2]) println()
    
}

