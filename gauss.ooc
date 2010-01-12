import structs/Array
import Matrix

// wooh, globals are evil
appName := ""

usage: func {
    
    printf("Usage: %s <rows>x<columns> a11 a12 a13 ... a21 a22 a23..\n", appName)
    
}

main: func (args: Array<String>) {
    
    appName = args[0]
    
    if(args size() < 3) {
        usage()
        exit(0)
    }
    
    width, height: Int
    if(!args[1] scanf("%dx%d", height&, width&)) {
        printf("Incorrect rows/column format!")
        usage()
        exit(0)
    }
    
    m := Matrix new(width, height)
    
    i := 2
    for(y in 0..height) {
        for(x in 0..width) {
            if(i >= args size()) {
                printf("Missing arguments! Expected %dx%d = %d values\n", width, height, width * height)
                exit(0)
            }
            m set(x, y, args[i] toFloat())
            i += 1
        }
    }
    
    "m = " println()
    m print()
    
    r := gaussReduce(m)
    
    "r = " println()
    r print()
    
}


gaussReduce: func (m : Matrix) -> Matrix {
    
    width  := m getWidth()
    height := m getHeight()
    
    r := Matrix new(m)
    
    for(x in 0..height) {
        
        "Mul-ing row %d with %.2f" format(x, 1.0 / r[x, x]) println()
        r rowMul(x, 1.0 / r[x, x])
        
        "r = " println()
        r print()
        
        for(y in 0..height) {
            if(x == y) {
                continue
            } else {
                fac := r[x, y]
                "Adding %.2f times row %d to row %d" format(-fac, x, y) println()
                r rowAdd(x, y, -fac)
            }
        }
    }
    
    "At the end, r = " println()
    r print()
    
    r

}
