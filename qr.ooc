import structs/[Array, ArrayList]
import Matrix, Vector

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
    
    q, r : Matrix
    qrDecomposition(m, q&, r&) // out parameters ftw
    
    "q = " println()
    q print()
    
    "r = " println()
    r print()
    
    "q * r = " println()
    (q * r) print()
    
    "difference: " println()
    (m - (q * r)) print()
    
}


qrDecomposition: func (m : Matrix, q, r: Matrix@) {
    
    width  := m getWidth()
    height := m getHeight()
    
    a := ArrayList<Vector> new()
    for(x in 0..width) {
        v := Vector new(height)
        for(y in 0..height) {
            v[y] = m[x, y]
        }
        a add(v)
    }
    
    "===== a ======" println()
    for(column in a) {
        column print()
    }
    "==============\n" println()
    
    u := ArrayList<Vector> new()
    e := ArrayList<Vector> new()

    for(y in 0..width) {
        un := Vector new(a[y])
        for(i in 1..(y+1)) {
            "i = %d" format(i) println()
            un = un - un project(e[i - 1])
        }
        u add(un)
        e add(un normalize())
    }
    
    "===== u ======" println()
    for(column in u) {
        column print()
    }
    "==============\n" println()
    
    "===== e ======" println()
    for(column in e) {
        column print()
    }
    "==============\n" println()

    q = Matrix new~fromCols(e)
    
    "q = " println()
    q print()
    
    exit(0)

}
