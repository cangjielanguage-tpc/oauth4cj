// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*
from std import collection.HashMap
from std import collection.ArrayList


// public func addQuerystring(queryString: String)
public func testParameterList_05():Int32 {
    var map = HashMap<String, String>()
    var list_1 = ParameterList(map)
    var queryString_1 = ""
    list_1.addQuerystring(queryString_1)
    var paraList_1 = list_1.getParams()
    if (paraList_1.size != 0){
        return -1
    }

    map.put("key1", "value1")
    var list_2 = ParameterList(map)
    var queryString_2 = "key2=value2&key3=value3"
    list_2.addQuerystring(queryString_2)
    var paraList_2 = list_2.getParams()
    if (paraList_2.size != 3){
        return -1
    }
    
    var list_3 = ParameterList(map) 
    var queryString_3 = "key4=value4&key5"
    list_3.addQuerystring(queryString_3)
    var paraList_3 = list_3.getParams()
    if (paraList_3.size != 3){
        return -1
    }

    return 0
}

// public func sort()
public func testParameterList_06():Int32 {
    var map = HashMap<String, String>()
    map.put("3", "3")
    map.put("5", "5")
    map.put("2", "2")
    map.put("4", "4")
    map.put("1", "1")
    var list = ParameterList(map)
    var paraList = list.sort().getParams()
    var flag = false
    for (i in 0..paraList.size) {
        var key = paraList[i].getKey()
        var sizeString = (i+1).toString()
        if (!sizeString.equals(key)) {
            println(key)
            println(sizeString)
            flag = true
        }
    }
    if (flag) {
        return -1
    }
    return 0
}

// public func asOauthBaseString()
public func testParameterList_07():Int32 {
    var map = HashMap<String, String>()
    map.put("key1", "value1")
    var list = ParameterList(map)
    var paraString = list.asOauthBaseString()
    if (!"key1=value1".equals(OAuthEncoder.decode(paraString))) {
        return -1
    }
    return 0
}

main() {
    var test_05 = testParameterList_05()
    var test_06 = testParameterList_06()
    var test_07 = testParameterList_07()

    var sum = test_05+test_06+test_07
    println(sum)
    println("test_05=${test_05}, test_06=${test_06}, test_07=${test_07}")
    return sum
}