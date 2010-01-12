use math

Vector: class {

    size: Int
    data: Float*
    
    init: func ~fromsize (=size) {
        data = gc_malloc(Float size * size)
    }
    
    init: func ~copy (src: This) {
        this~fromsize(src size)
        memcpy(this data, src data, Float size * size)
    }
    
    set: func (i: Int, val: Float) {
        data[i] = val
    }
    
    get: func (i: Int) -> Float {
        return data[i]
    }
    
    mul: func (factor: Float) {
        for(i in 0..size) {
            this[i] = factor * this[i]
        }
    }
    
    add: func (v2: This) -> This {
        v1 := this
        v3 := This new(size)
        for(i in 0..size) v3[i] = v1[i] + v2[i]
        v3
    }
    
    sub: func (v2: This) -> This {
        v1 := this
        v3 := This new(size)
        for(i in 0..size) v3[i] = v1[i] - v2[i]
        v3
    }
    
    dot: func (v2: This) -> Float {
        val := 0.0
        v1 := this
        for(i in 0..size) {
            val += v1[i] * v2[i]
        }
        val
    }
    
    project: func (v: Vector) -> This {
        result := new(v)
        result mul(this dot(v) / v dot(v))
        result
    }
    
    norm: func -> Float { sqrt(this dot(this)) }
    
    normalize: func -> This {
        v := new(this)
        v mul(1.0 / norm())
        v
    }
    
    print: func {
        printf("(")
        for(i in 0..size) {
            printf("%.4f", this[i])
            
            if(i != (size - 1)) {
                printf(", ")
            }
        }
        printf(")\n")
    }
    
    getSize:  func -> Int { size }

}


operator *   (v1, v2: Vector) -> Float  { v1 dot(v2) }    // dot product
/*
operator ^   (v1, v2: Vector) -> Vector { v1 cross(v2) } // cross product
*/
operator +   (v1, v2: Vector) -> Vector { v1 add(v2) }
operator -   (v1, v2: Vector) -> Vector { v1 sub(v2) }

operator []  (v: Vector, i: Int) -> Float    { v get(i) }
operator []= (v: Vector, i: Int, val: Float) { v set(i, val) }

