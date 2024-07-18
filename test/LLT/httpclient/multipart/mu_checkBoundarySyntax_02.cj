
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
public import oauth4cj.*

func testNotValidBoundary(boundary: String): Int32 {
    try {
        MultipartUtils.checkBoundarySyntax(boundary)
    } catch (e: IllegalArgumentException) {
        let err: String = "{'boundary'='" + boundary + "'} has invalid syntax. Should be '"
        println("err = ${err}")
        println("e.message = ${e.message}")
        if (e.message.startsWith(err)) {
            return 0
        }
        //e.printStackTrace()
        println(-1)
        return -1
    }
    println(-2)
    return -2
}

main() {

    var test_01 = testCheckBoundarySyntax_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testCheckBoundarySyntax_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testCheckBoundarySyntax_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testCheckBoundarySyntax_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testCheckBoundarySyntax_01(): Int32 {
    let num: Int32 = testNotValidBoundary("0aA'()+_,-./:=? ")
    if (num != 0){
        println(1)
        return 1
    }
    return num
}

public func testCheckBoundarySyntax_02(): Int32 {
    let num: Int32 = testNotValidBoundary("")
    if (num != 0){
        println(2)
        return 2
    }
    return num
}

public func testCheckBoundarySyntax_03(): Int32 {
    let num: Int32 = testNotValidBoundary("0aA'()+_;,-./:=? ")
    if (num != 0){
        println(3)
        return 3
    }
    return num
}

public func testCheckBoundarySyntax_04(): Int32 {
    let num: Int32 = testNotValidBoundary("12345678901234567890123456789012345678901234567890123456789012345678901")
    if (num != 0){
        println(4)
        return 4
    }
    return num
}

