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
    
    l, u : Matrix
    luDecomposition(m, l&, u&) // out parameters ftw
    
    "l = " println()
    l print()
    
    "u = " println()
    u print()
    
    "l * u = " println()
    (l * u) print()
    
    "difference: " println()
    (m - (l * u)) print()
    
}


luDecomposition: func (m : Matrix, l, u: Matrix@) {
    
    width  := m getWidth()
    height := m getHeight()
    
    l = Matrix new(width, height)
    for(x in 0..width) l set(x, x, 1)
    
    u = Matrix new(m)
    
    for(x in 0..(width - 1)) {
        for(y in (x + 1)..height) {
            denom := u get(x, x)
            numer := u get(x, y)
            fac := numer / denom
            l set(x, y, fac)
            u rowAdd(x, y, -fac)
        }
    }

}
