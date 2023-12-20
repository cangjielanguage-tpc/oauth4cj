// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

from std import collection.HashMap
from std import collection.ArrayList
from std import io.*

// Response

// public init(200, "message", headers, stream, closeables, "") getCode() getMessage() getHeaders() getHeader("header2") getBody()
public func testResponse_01():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    //var stream:ByteArrayStream = ByteArrayStream()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, "123456")
    if (response.getCode() != 200){ 
        return -1
    }
    if ("message" != response.getMessage()){
        return -1
    }
    var map = response.getHeaders()
    if ("value1" != map["header1"]){
        return -1
    }
    if ("value2" != response.getHeader("header2")){
        return -1
    }
    if ("123456" != response.getBody()){
        return -1
    }
    return 0
}

// isSuccessful()
public func testResponse_02():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    //var stream:ByteArrayStream = ByteArrayStream()
    var response_1: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, "123456")
    if (!response_1.isSuccessful()) {
        return -1
    }
    var response_2: OAuth4cjResponse = OAuth4cjResponse(400, "message", headers, "123456")
    if (response_2.isSuccessful()) {
        return -1
    }
    var response_3: OAuth4cjResponse = OAuth4cjResponse(388, "message", headers, "123456")
    if (!response_3.isSuccessful()) {
        return -1
    }
    var response_4: OAuth4cjResponse = OAuth4cjResponse(404, "message", headers, "123456")
    if (response_4.isSuccessful()) {
        return -1
    }
    var response_5: OAuth4cjResponse = OAuth4cjResponse(100, "message", headers, "123456")
    if (response_5.isSuccessful()) {
        return -1
    }
    return 0
}

// getStream() getBody() toString()
public func testResponse_03():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Resource> = ArrayList<Resource>()
    stream.write("abcdefg".toArray()) // 向流中写入测试数据
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, stream, closeables)
    var responseStream = response.getStream()
    var buffer:Array<Byte> = Array<Byte>(7, item:0)
    responseStream.read(buffer) 
    var str_1 = String.fromUtf8(buffer)
    println(str_1)
    if ("abcdefg" != str_1){
        println(str_1)
        return -1
    }
    var str_2:String = response.toString()
    println(str_2)
    if ("Response{code=200, message='message', body='', headers=[]}" != str_2){
        println(str_2)
        return -1
    }
    return 0
}

public func testResponse_04():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    headers.put("Content-Encoding", "zlib") 

    var str = "abcdefg"
    var bytes: Array<UInt8> = str.toArray()
    var stream:ByteArrayStream = ByteArrayStream(64)
    stream.write(bytes)

    var closeables:ArrayList<Resource> = ArrayList<Resource>()
    var response: OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, stream, closeables)
    var body:String = response.getBody()
    
    if (str != body) {
        return -1
    }
    return 0
}


main() {
    var test_01 = testResponse_01()
    var test_02 = testResponse_02()
    var test_03 = testResponse_03()
    var test_04 = testResponse_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}