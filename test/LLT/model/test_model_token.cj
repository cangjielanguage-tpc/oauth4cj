// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

var flag:Bool = false

// init("abcdefg") getRawResponse() 
public func testToken_01():Int32 {
    var token:Token = Token("abcdefg")
    var rawResponse:String = token.getRawResponse()
    if (rawResponse.equals("abcdefg")) {
        return 0
    } 
    return -1
} 

// init("abcdefg") getParameter("abcdefg") 
public func testToken_02():Int32 {
    var token:Token = Token("abcdefg")
    var parameter:String = token.getParameter("abcdefg")
    if (parameter.equals("")) {
        return 0
    } 
    return -1
}

// init("a=1") getParameter("a")
public func testToken_03():Int32 {
    var token:Token = Token("a=1")
    var parameter:String = token.getParameter("a")
    if (parameter.equals("1")) {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=3") getRawResponse()
public func testToken_04():Int32 {
    var token:Token = Token("a=1&b=2&c=3")
    var rawResponse:String = token.getRawResponse()
    if (rawResponse.equals("a=1&b=2&c=3")) {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=3") getParameter("b")
public func testToken_05():Int32 {
    var token:Token = Token("a=1&b=2&c=3")
    var parameter:String = token.getParameter("b")
    if (parameter.equals("2")) {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=") getParameter("c") 
public func testToken_06():Int32 {
    var token:Token = Token("a=1&b=2&c=")
    var parameter:String = token.getParameter("c")
    if (parameter.equals("")) {
        return 0
    } 
    return -1
}

main() {
    var test_01 = testToken_01()
    var test_02 = testToken_02()
    var test_03 = testToken_03()
    var test_04 = testToken_04()
    var test_05 = testToken_05()
    var test_06 = testToken_06()

    var sum = test_01+test_02+test_03+test_04+test_05+test_06
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}," +
            "test_05=${test_05}, test_06=${test_06}")
    return sum
}
