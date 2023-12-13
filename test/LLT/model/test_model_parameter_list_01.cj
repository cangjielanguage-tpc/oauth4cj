// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*
from std import collection.HashMap
from std import collection.ArrayList

// public init()   public func size()  public func getParams()
public func testParameterList_01():Int32 {
    var list = ParameterList()
    if (list.size() != 0) {
        return -1
    }
    var paraList = list.getParams()
    if (paraList.size != 0){
        return -1
    }

    var map = HashMap<String, String>()
    var list_2 = ParameterList(map)
    if (list_2.size() != 0) {
        return -1
    }
    return 0
}

// public init(map: HashMap<String, String>)  public func contains(param: OAuth4cjParameter) public func getParams()
public func testParameterList_02():Int32 {
    var map = HashMap<String, String>()
    map.put("key1", "value1")
    map.put("key2", "value2")
    map.put("key3", "value3")
    var list = ParameterList(map)

    var para = OAuth4cjParameter("key2", "value2")
    if (!list.contains(para)) {
        return -1
    }
    var para_2 = OAuth4cjParameter("key4", "value4")
    if (list.contains(para_2)) {
        return -1
    }

    var paraList = list.getParams()
    if (paraList.size != 3){
        return -1
    }
    return 0
}

// public func add(key: String, value: String) public func addAll(other: ParameterList)
public func testParameterList_03():Int32 {
    var list = ParameterList()
    list.add("key1", "value1")
    list.add("key2", "value2")
    if (list.size() != 2) {
        return -1
    }

    var map = HashMap<String, String>()
    map.put("key1", "value1")
    map.put("key2", "value2")
    map.put("key3", "value3")
    var list_2 = ParameterList(map)
    list.addAll(list_2)
    if (list.size() != 5) {
        return -1
    }
    return 0
}

// public func appendTo(url: String)  public func asOauthBaseString()
public func testParameterList_04():Int32 {
    var list = ParameterList()
    list.add("key1", "value1")
    list.add("key2", "value2")

    var url = "http://test/"
    var result = list.appendTo(url)
    var expectString = "http://test/?key1=value1&key2=value2"
    println("result = ${result}")
    if (expectString != result) {
        println(result)
        return -1
    }

    var url_2 = "http://test/test_02?a=b"
    var result_2 = list.appendTo(url_2)
    var expectString_2 = "http://test/test_02?a=b&key1=value1&key2=value2"
    println("result_2 = ${result_2}")
    if (expectString_2 != result_2) {
        println(result_2)
        return -1
    }

    var list_2 = ParameterList()
    var url_3 = "http://test/test_03"
    var result_3 = list_2.appendTo(url_3)
    println("result_3 = ${result_3}")
    if (url_3 != result_3) {
        println(result_3)
        return -1
    }
    return 0
}


main() {
    var test_01 = testParameterList_01()
    var test_02 = testParameterList_02()
    var test_03 = testParameterList_03()
    var test_04 = testParameterList_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}