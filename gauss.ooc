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
    
    "initial matrix = " println()
    m print()
    
    r := gaussReduce(m)
    
    "final matrix = " println()
    r print()
    
}


gaussReduce: func (m : Matrix) -> Matrix {
    
    width  := m getWidth()
    height := m getHeight()
    
    r := Matrix new(m)
    
    for(x in 0..height) {
        
        // if the xth element of the row is null, we should swap
        if(r[x, x] == 0) {
            okay := false
            for(x2 in (x+1)..height) {
                if(r[x, x2] != 0) {
                    printf("Recovered from null-beginning row %d! We're gonna use %d instead\n", x, x2)
                    r rowSwap(x, x2)
                    r print()
                    printf("Resuming normal Gaussian process\n")
                    okay = true
                    break
                }
            }
            if(!okay) {
                singular := false
                for(y2 in (x+1)..height) {
                    for(x2 in 0..width) {
                        if(r[x2, y2] != 0) {
                            singular = true
                            break
                        }
                    }
                }
                
                if(singular) {
                    printf("\nSingular matrix! no solutions.\n")
                } else {
                    printf("\nFinished resolving! The solution space is %s\n", 
                        match (height - x) {
                            case 0 => "a point"
                            case 1 => "a line"
                            case 2 => "a plane"
                            case 3 => "three-dimensional!"
                        }
                    )
                }
                return r
            }
        }
        
        "Mul-ing row %d with %.2f" format(x, 1.0 / r[x, x]) println()
        r rowMul(x, 1.0 / r[x, x])
        
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
    
    r

}
