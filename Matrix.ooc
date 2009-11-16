Matrix: class {

    width, height: Int
    data: Float*
    
    init: func (=width, =height) {
        data = gc_malloc(Float size * width * height)
    }
    
    init: func ~copy (src: This) {
        this(src width, src height)
        memcpy(this data, src data, Float size * width * height)
    }
    
    set: func (x, y: Int, val: Float) {
        data[x + y * width] = val
    }
    
    get: func (x, y: Int) -> Float {
        return data[x + y * width]
    }
    
    lineAdd: func (srcLine, dstLine: Int, factor: Float) {
        for(x in 0..width) {
            set(x, dstLine, get(x, dstLine) + get(x, srcLine) * factor)
        }
    }

    sub: func (m2: This) -> This {
        m1 := this
        m3 := This new(width, height)
        for(y in 0..height) {
            for(x in 0..width) {
                m3 set(x, y, m1 get(x, y) - m2 get(x, y))
            }
        }
        return m3
    }
    
    mul: func (m2: This) -> This {
        m1 := this
        m3 := This new(m2 width, m1 height)
        for(m2x in 0..m2 width) {
            for(m1y in 0..m1 height) {
                sum := 0.0
                for(m2y_m1x in 0..m2 height) {
                    sum += m1 get(m2y_m1x, m1y) * m2 get(m2x, m2y_m1x)
                }
                m3 set(m2x, m1y, sum)
            }
        }
        return m3
    }
    
    print: func {
        printf("┌")
        for(x in 0..(width * 7 + 1)) printf("─")
        printf("┐\n")
        
        for(y in 0..height) {
            printf("│")
            for(x in 0..width) {
                printf(" %6.2f", get(x, y))
            }
            printf(" │\n")
            
            if(y != (height - 1)) {
                printf("│")
                for(x in 0..(width * 7 + 1)) printf(" ")
                printf("│\n")
            }
        }
        
        printf("└")
        for(x in 0..(width * 7 + 1)) printf("─")
        printf("┘\n")
    }

}

operator * (m1, m2: Matrix) -> Matrix { m1 mul(m2) }
operator - (m1, m2: Matrix) -> Matrix { m1 sub(m2) }

