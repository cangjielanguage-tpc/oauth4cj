// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

main() {

    var test_01 = testMultipartUtils_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testMultipartUtils_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartUtils_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartUtils_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartUtils_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

public func testMultipartUtils_01(): Int32 {
    let str: String = MultipartUtils.parseBoundaryFromHeader("multipart/subtype; boundary=\"0aA'()+_,-./:=?\"")
    let result: String = "0aA'()+_,-./:=?"
    if (!str.equals(result)) {
        println(1)
        return 1
    }
    return 0
}

public func testMultipartUtils_02(): Int32 {
    let str: String = MultipartUtils.parseBoundaryFromHeader("multipart/subtype; boundary=\"0aA'()+_, -./:=?\"")
    let result: String = "0aA'()+_, -./:=?"
    if (!str.equals(result)) {
        println(2)
        return 2
    }
    return 0
}

public func testMultipartUtils_03(): Int32 {
    let str: String = MultipartUtils.parseBoundaryFromHeader("multipart/subtype; boundary=\"0aA'()+_, -./:=? \"")
    let result: String = "0aA'()+_, -./:=?"
    if (!str.equals(result)) {
        println(3)
        return 3
    }
    return 0
}

public func testMultipartUtils_04(): Int32 {
    let str: String = MultipartUtils.parseBoundaryFromHeader("multipart/subtype; boundary=0aA'()+_,-./:=?")
    let result: String = "0aA'()+_,-./:=?"

    if (!str.equals(result)) {
        println(4)
        return 4
    }
    return 0
}

public func testMultipartUtils_05(): Int32 {
    let str: String = MultipartUtils.parseBoundaryFromHeader("multipart/subtype; boundary=0aA'()+_, -./:=?")
    let result: String = "0aA'()+_, -./:=?"

    if (!str.equals(result)) {
        println(5)
        return 5
    }
    return 0
}
