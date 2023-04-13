// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import exceptions.*
from std import collection.HashMap
from std import collection.ArrayList
from std import io.*

// public init(rawResponse: Response) public func getResponse()
public func testException_01():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response:Response = Response(200, "message", headers, "123456")
    var exception = OAuthResponseException(response)
    var result = exception.getResponse()
    if (result.getCode() != 200){ 
        return -1
    }
    if (!"message".equals(result.getMessage())){ 
        return -1
    }
    var map = result.getHeaders()
    if (!"value1".equals(map["header1"])){ 
        return -1
    }
    if (!"value2".equals(result.getHeader("header2"))){ 
        return -1
    }
    if (!"123456".equals(result.getBody())){ 
        return -1
    }
    return 0
}

// public func equals(obj: OAuthResponseException)
public func testException_02():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response:Response = Response(200, "message", headers, "123456")
    var exception = OAuthResponseException(response)
    var exception_2 = exception //内存地址相同
    if (!exception.equals(exception_2)) {
        return -1
    }
    return 0
}

// public func equals(obj: OAuthResponseException)
public func testException_03():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response:Response = Response(200, "message", headers, "123456")
    var exception = OAuthResponseException(response)
    var exception_2 = OAuthResponseException(response) //内存地址不同
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