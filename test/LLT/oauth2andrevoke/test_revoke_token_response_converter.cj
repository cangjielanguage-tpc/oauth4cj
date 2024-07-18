// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
public import oauth4cj.*
import std.io.*

func testTokenReponseConverter_01(): Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse  = OAuth4cjResponse(200, "message", headers, "123456")
    var converter: OAuth2RevokeTokenResponseConverter = OAuth2RevokeTokenResponseConverter()
    converter.convert(response)
    return 0
}

func testTokenReponseConverter_02(): Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse  = OAuth4cjResponse(300, "message", headers, "123456")
    var converter: OAuth2RevokeTokenResponseConverter = OAuth2RevokeTokenResponseConverter()
    try {
        converter.convert(response)
        return -1
    } catch (e: OAuth2AccessTokenErrorResponseException) {
        return 0
    }
}

func testTokenReponseConverter_03(): Int32 {
    let responseBody: String = 
        ##"{"error":"server_error","error_description":"server not found","error_uri":"http://www.test.com"}"##
    var headers:HashMap<String, String> = HashMap<String, String>()
    headers.put("header1", "value1")
    headers.put("header2", "value2")
    var response: OAuth4cjResponse  = OAuth4cjResponse(404, "message", headers, responseBody)
    var converter: OAuth2RevokeTokenResponseConverter = OAuth2RevokeTokenResponseConverter()
    try {
        converter.convert(response)
        return -1
    } catch (e: OAuth2AccessTokenErrorResponseException) {
        var error = e.getError()
        match(error) {
            case Some(x) => println(x.getErrorString())
            case _ => println("error is null")
        }
        var errorDescription = e.getErrorDescription()
        var url = e.getErrorUri()
        println(errorDescription)
        println(url)
        return 0
    }
}

func testTokenReponseConverter_04(): Int32 {
    var converter=OAuth2RevokeTokenResponseConverter()
    var inputStream=ByteArrayStream()
    inputStream.write("hello cangjie".toArray())
    //println(inputStream.isEmpty())
    var response=OAuth4cjResponse(Int32(400),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>())
    try {
        converter.convert(response)
        return -1
    } catch (e: OAuth2AccessTokenErrorResponseException) {
        return 0
    }
}

main() {
    var test_01 = testTokenReponseConverter_01()
    var test_02 = testTokenReponseConverter_02()
    var test_03 = testTokenReponseConverter_03()
    var test_04 = testTokenReponseConverter_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}