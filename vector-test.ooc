import Vector

main: func {
    
    v := Vector new(3)
    
    v[0] = 1
    v[1] = 1
    v[2] = 1
    
    "v                    = "       print(); v print()
    "v norm()             = %.4f"   format(v norm()) println()
    "v normalize()        = "       print();   v normalize() print()
    "v normalize() norm() = %.4f"   format(v normalize() norm()) println()
    
    vn := v normalize()
    
    v2 := Vector new(3)
    
    v2[0] = 3.41
    v2[1] = 2.31
    v2[2] = 1.59
    
    vp := v2 project(vn)
    "vp = " print(); vp print()
    
}