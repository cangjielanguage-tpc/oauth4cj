// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

// from encoding import url.*

// public func addBodyParameter(key: String, value: String)  public func getBodyParams()
// public func addParameter(key: String, value: String)
public func testRequest_05():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    request.addBodyParameter("key1", "value1")
    request.addBodyParameter("key2", "value2")

    var result_1 = request.getBodyParams().getParams()
    if (result_1.size != 2){
        return -1
    }

    request.addParameter("key3", "value3")
    var result_2 = request.getBodyParams().getParams()
    if (result_2.size != 2){
        return -1
    }
    var newUrl = "http://test/test?key3=value3"
    if (!newUrl.equals(request.getCompleteUrl())) {
        return -1
    }

    return 0
}

// public func addParameter(key: String, value: String)  public func toString()
public func testRequest_06():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.DELETE, url)
    var result_1 = request.getBodyParams().getParams()
    if (result_1.size != 0){
        return -1
    }
    request.addParameter("key3", "value3")
    var result_2 = request.getBodyParams().getParams()
    if (result_2.size != 1){
        return -1
    }

    var str = request.toString()
    if (!"@Request(DELETE http://test/test)".equals(str)) {
        println(str)
        return -1
    }
    return 0
}

// public func getQueryStringParams()
public func testRequest_07():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.DELETE, url)
    var queryParamList = request.getQueryStringParams()
    if (queryParamList.size() != 0) {
        return -1
    }

    var url_2 = "http://test/test?key1=value1&key2=value2"
    var request_2 = OAuth4cjRequest(Verb.GET, url_2)
    var queryParamList_2 = request_2.getQueryStringParams()
    if (queryParamList_2.size() != 2) {
        return -1
    }

    var url_3 = "#$、@^&^*&()__+~>M?;"
    var request_3 = OAuth4cjRequest(Verb.GET, url_3)  
    var flag = true
    try {
        var queryParamList_3 = request_3.getQueryStringParams()
        println(queryParamList_3.size())
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag = false
    }
    if (flag) {
        return -1
    }

    return 0
}


main() {
    var test_05 = testRequest_05()
    var test_06 = testRequest_06()
    var test_07 = testRequest_07()

    var sum = test_05+test_06+test_07
    println(sum)
    println("test_05=${test_05}, test_06=${test_06}, test_07=${test_07}")
    return sum
}