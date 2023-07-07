// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import exceptions.*
from std import collection.HashMap
from std import collection.ArrayList

var map02: HashMap<String,String> = HashMap<String,String>([("key01","value01"),("key02","value02")])

public func testParameterList_01(): Int32 {

    let pars = ParameterList(map02)
    let queryString01: String = "=abc"
    pars.addQuerystring(queryString01)

    if (pars.size() != (map02.size + 1)) {
        println(1)
        return 1
    }
    if (!pars.contains(Parameter("","abc"))){
        println(2)
        return 2
    }
    return 0
}

public func testParameterList_02(): Int32 {
    let pars = ParameterList(map02)
    let queryString02: String = "ab=c"
    pars.addQuerystring(queryString02)
    
    if (pars.size() != (map02.size + 1)) {
        println(4)
        return 4
    }
    if (!pars.contains(Parameter("ab","c"))){
        println(5)
        return 5
    }
    return 0
}

public func testParameterList_03(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "abc="
    pars.addQuerystring(queryString03)
    
    if (pars.size() != (map02.size + 1)) {
        println(6)
        return 6
    }
    if (!pars.contains(Parameter("abc",""))){
        println(7)
        return 7
    }
    return 0
}

public func testParameterList_04(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "="

    try {
    	pars.addQuerystring(queryString03)
    } catch (e: Exception) {
    	//e.printStackTrace()
    	return 0
    }
    println(8)
    return 8
}


public func testParameterList_05(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "=="

    try {
    	pars.addQuerystring(queryString03)
    } catch (e: Exception) {
    	//e.printStackTrace()
    	return 0
    }
    println(9)
    return 9
}

public func testParameterList_06(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "abc&&&&&&"
    pars.addQuerystring(queryString03)

    if (pars.size() != (map02.size + 1)) {
        println(10)
        return 10
    }
    if (!pars.contains(Parameter("abc",""))){
        println(11)
        return 11
    }
    return 0
}

public func testParameterList_07(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "&&&&&bc"
    pars.addQuerystring(queryString03)

    if (pars.size() != (map02.size + 6)) {
        println(12)
        return 12
    }
    if (!pars.contains(Parameter("bc",""))){
        println(13)
        return 13
    }
    return 0
}

public func testParameterList_08(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "===bc"
    pars.addQuerystring(queryString03)

    if (pars.size() != (map02.size + 1)) {
        println(12)
        return 12
    }
    if (!pars.contains(Parameter("",""))){
        println(13)
        return 13
    }
    return 0
}

public func testParameterList_09(): Int32 {
    let pars = ParameterList(map02)
    let queryString03: String = "bc==="
    pars.addQuerystring(queryString03)

    if (pars.size() != (map02.size + 1)) {
        println(14)
        return 14
    }
    if (!pars.contains(Parameter("bc",""))){
        println(15)
        return 15
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
    test_01 = testParameterList_09()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}