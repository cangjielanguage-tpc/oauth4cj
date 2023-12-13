// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

var flag:Bool = false

// init() getRawResponse() 预期抛异常
public func testToken_01():Int32 {
    var token:Token = Token()
    var rawResponse:String = token.getRawResponse()
    if (rawResponse == "") {
        return 0
    } 
    return -1
} 

// init() getParameter("") 预期抛异常
public func testToken_02():Int32 {
    var token:Token = Token("")
    var parameter:String = token.getParameter("")
    if (parameter == "") {
        return 0
    } 
    return -1
}

// init("abcdefg") getRawResponse() 预期返回"abcdefg"
public func testToken_03():Int32 {
    var token:Token = Token("abcdefg")
    var rawResponse:String = token.getRawResponse()
    if (rawResponse == "abcdefg") {
        return 0
    } 
    return -1
}

// init("abcdefg") getParameter("abcdefg") 预期返回""
public func testToken_04():Int32 {
    var token:Token = Token("abcdefg")
    var parameter:String = token.getParameter("abcdefg")
    if (parameter == "") {
        return 0
    } 
    return -1
}

// init("a=1") getParameter("a") 预期返回"1"
public func testToken_05():Int32 {
    var token:Token = Token("a=1")
    var parameter:String = token.getParameter("a")
    if (parameter == "1") {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=3") getRawResponse() 预期返回"a=1&b=2&c=3"
public func testToken_06():Int32 {
    var token:Token = Token("a=1&b=2&c=3")
    var rawResponse:String = token.getRawResponse()
    if (rawResponse == "a=1&b=2&c=3") {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=3") getParameter("b") 预期返回"2"
public func testToken_07():Int32 {
    var token:Token = Token("a=1&b=2&c=3")
    var parameter:String = token.getParameter("b")
    if (parameter == "2") {
        return 0
    } 
    return -1
}

// init("a=1&b=2&c=") getParameter("c") 预期返回""
public func testToken_08():Int32 {
    var token:Token = Token("a=1&b=2&c=")
    var parameter:String = token.getParameter("c")
    if (parameter == "") {
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
    var test_07 = testToken_07()
    var test_08 = testToken_08()

    var sum = test_01+test_02+test_03+test_04+test_05+test_06+test_07+test_08
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}," +
            "test_05=${test_05}, test_06=${test_06}, test_07=${test_07}, test_08=${test_08}")
    return sum
}