// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*
from std import collection.HashMap
from std import collection.ArrayList
from std import io.*

// public init(rawResponse: Response) public func getResponse()
public func testException_01():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    //var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, "123456")
    var exception = OAuth4cjResponseException(response)
    var result = exception.getResponse()
    if (result.getCode() != 200){ 
        return -1
    }
    if ("message" != result.getMessage()){
        return -1
    }
    var map = result.getHeaders()
    if ("value1" != map["header1"]){
        return -1
    }
    if ("value2" != result.getHeader("header2")){
        return -1
    }
    if ("123456" != result.getBody()){
        return -1
    }
    return 0
}

// public func equals(obj: OAuth4cjResponseException)
public func testException_02():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    //var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, "123456")
    var exception = OAuth4cjResponseException(response)
    var exception_2 = exception //内存地址相同
    if (!exception.equals(exception_2)) {
        return -1
    }
    return 0
}

// public func equals(obj: OAuth4cjResponseException)
public func testException_03():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    //var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, "123456")
    var exception = OAuth4cjResponseException(response)
    var exception_2 = OAuth4cjResponseException(response) //内存地址不同
    if (!exception.equals(exception_2)) {
        return -1
    }
    return 0
}

main() {
    var test_01 = testException_01()
    var test_02 = testException_02()
    var test_03 = testException_03()

    var sum = test_01+test_02+test_03
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}")
    return sum
}