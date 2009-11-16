import structs/Array
import Matrix

main: func (args: Array<String>) {
    
    if(args size() < 3) {
        printf("Usage: %s <width> a11 a12 a13 ... a21 a22 a23..\n", args[0])
        exit(0)
    }
    
    width := args[1] toInt()
    height := width
    
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
    
    l := Matrix new(width, height)
    for(x in 0..width) l set(x, x, 1)
    
    u := Matrix new(m)
    
    for(x in 0..(width - 1)) {
        for(y in (x + 1)..height) {
            denom := u get(x, x)
            numer := u get(x, y)
            fac := numer / denom
            //printf("fac = %.1f / %.1f = %.1f\n", numer, denom, fac)
            l set(x, y, fac)
            //printf("Adding line %d to line %d with factor %.1f\n", x, y, fac)
            u lineAdd(x, y, -fac)
        }
    }
    
    "l = " println()
    l print()
    
    "u = " println()
    u print()
    
    "l * u = " println()
    (l * u) print()
    
    "difference: " println()
    (m - (l * u)) print()
    
}
