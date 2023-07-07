// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import exceptions.*
from std import collection.HashMap
from std import collection.ArrayList

var map02: HashMap<String,String> = HashMap<String,String>([("key01","value01"),("key02","value02")])

// public init()   public func size()  public func getParams()
public func testParameterList_01(): Int32 {

    let pars = ParameterList(map02)
    let queryString01: String = "&abc"
    pars.addQuerystring(queryString01)

    if (pars.size() != (map02.size + 2)) {
        println(1)
        return 1
    }
    if (!pars.contains(Parameter("abc",""))){
        println(2)
        return 2
    }
    if (!pars.contains(Parameter("",""))){
        println(3)
        return 3
    }
    return 0
}

// public init(map: HashMap<String, String>)  public func contains(param: Parameter) public func getParams()
public func testParameterList_02(): Int32 {
    let pars = ParameterList(map02)
    let queryString02: String = "a&bc"
    pars.addQuerystring(queryString02)
    
    if (pars.size() != (map02.size + 2)) {
        println(4)
        return 4
    }
    if (!pars.contains(Parameter("a",""))){
        println(5)
        return 5
    }
    if (!pars.contains(Parameter("bc",""))){
        println(6)
        return 6
    }

    return 0
}

public func testParameterList_03(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "abc&"
    pars.addQuerystring(queryString03)
    
    if (pars.size() != (map02.size + 1)) {
        println(7)
        return 7
    }
    if (!pars.contains(Parameter("abc",""))){
        println(8)
        return 8
    }
    return 0
}

public func testParameterList_04(): Int32 {

    let pars = ParameterList(map02)
    let queryString01: String = "=a&bc&c=1"
    let queryString02: String = "a&bd=c"
    let queryString03: String = "b=c"
    pars.addQuerystring(queryString01)
    pars.addQuerystring(queryString02)
    pars.addQuerystring(queryString03)
    if (pars.size() != (map02.size + 3 + 2 + 1)) {
        println(9)
        return 9
    }
    if (!pars.contains(Parameter("","a"))){
        println(10)
        return 10
    }
    if (!pars.contains(Parameter("bc",""))){
        println(11)
        return 11
    }
    if (!pars.contains(Parameter("c","1"))){
        println(12)
        return 12
    }
    if (!pars.contains(Parameter("a",""))){
        println(13)
        return 13
    }
    if (!pars.contains(Parameter("bd","c"))){
        println(14)
        return 14
    }
    if (!pars.contains(Parameter("b","c"))){
        println(15)
        return 15
    }

    return 0
}

public func testParameterList_05(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "&"
    pars.addQuerystring(queryString03)

    if (pars.size() != map02.size) {
        println(16)
        return 16
    }

    return 0
}

public func testParameterList_06(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = ""
    pars.addQuerystring(queryString03)

    if (pars.size() != map02.size) {
        println(17)
        return 17
    }
    return 0
}

public func testParameterList_07(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "&=&"

    try {
    	pars.addQuerystring(queryString03)
    } catch (e: Exception) {
    	//e.printStackTrace()
    	return 0
    }
    println(18)
    return 18
}

public func testParameterList_08(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "abc=bcd=cdv"
    pars.addQuerystring(queryString03)

    if (pars.size() != (map02.size + 1)) {
        println(19)
        return 19
    }
    if (!pars.contains(Parameter("abc","bcd"))){
        println(20)
        return 20
    }
    return 0
}

main() {

    var test_01 = testParameterList_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_07()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testParameterList_08()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}