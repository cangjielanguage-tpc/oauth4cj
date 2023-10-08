// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

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
    try {
        MultipartUtils.checkBoundarySyntax("0aA'()+_,-./:=?")
    } catch (e: Exception) {
        //e.printStackTrace()
        println(1)
        return 1
    }
    return 0
}

public func testCheckBoundarySyntax_02(): Int32 {
    try {
        MultipartUtils.checkBoundarySyntax("0aA'()+_,- ./:=?")
    } catch (e: Exception) {
        //e.printStackTrace()
        println(2)
        return 2
    }
    return 0
}

public func testCheckBoundarySyntax_03(): Int32 {
    try {
        MultipartUtils.checkBoundarySyntax(" 0aA'()+_,-./:=?")
    } catch (e: Exception) {
        //e.printStackTrace()
        println(3)
        return 3
    }
    return 0
}

public func testCheckBoundarySyntax_04(): Int32 {
    try {
        MultipartUtils.checkBoundarySyntax("1234567890123456789012345678901234567890123456789012345678901234567890")
    } catch (e: Exception) {
        //e.printStackTrace()
        println(4)
        return 4
    }
    return 0
}
