enum Precedence: Int {
    case infinity = 0
    case scope
    case assignment
    case conditional
    case arrayAcces
    case coalesce
    case and
    case or
    case compare
    case sum
    case product
    case prefix
    case arrow
}
    
