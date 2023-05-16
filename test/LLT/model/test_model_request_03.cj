// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import exceptions.*
from oauth4cj import httpclient.multipart.*

from std import collection.HashMap
from std import collection.ArrayList

// public func setMultipartPayload(multipartPayload: MultipartPayload)
// public func getMultipartPayload() public func initMultipartPayload() 
public func testRequest_09():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    request.initMultipartPayload() // 初始化空的MultipartPayload, 创建时会有一个默认添加"Content-Type"
    var result = request.getMultipartPayload().getHeaders()
    if (result.size != 1) {
        return -1
    }

    var payload = MultipartPayload()
    request.setMultipartPayload(payload)
    var result_2 = request.getMultipartPayload()
    if (!result_2.getBoundary().equals(payload.getBoundary())) {
        println(result_2.getBoundary())
        return -1
    }
    return 0
}

// public func initMultipartPayload() 不同参数
public func testRequest_10():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    // 设置范围"---test1---"
    request.initMultipartPayload("---test1---") 
    var result_1 = request.getMultipartPayload()
    if (!"---test1---".equals(result_1.getBoundary())) {
        println(result_1.getBoundary())
        return -1
    }

    // 设置范围"---test2---"
    request.initMultipartPayload("form-abc", "---test2---")
    var result_2 = request.getMultipartPayload()
    if (!"---test2---".equals(result_2.getBoundary())) {
        println(result_2.getBoundary())
        return -1
    }

    var map = HashMap<String, String>()
    map.put("Content-Type", "test")
    map.put("key3", "value3")
    // 用HashMap创建，会在Content-Type中追加默认的范围值
    // 如果没有Content-Type，会自动创建并追加默认范围值，然后添加到map中
    request.initMultipartPayload(map)
    var result_3 = request.getMultipartPayload().getHeaders()
    var header = result_3["Content-Type"]
    println("完整的Content-Type值: ${header}")
    if (!header.startsWith("test")) {
        return -1
    }
    return 0
}

// public func initMultipartPayload()  不同参数
public func testRequest_11():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    var map = HashMap<String, String>()
    map.put("Content-Type", "test")
    map.put("key1", "value1")
    request.initMultipartPayload("---test1---", map)
    var result_1 = request.getMultipartPayload().getHeaders()
    var header_1 = result_1["Content-Type"]
    if (!"test; boundary=\"---test1---\"".equals(header_1)) {
        println(header_1)
        return -1
    }
    if (!"value1".equals(result_1["key1"])) {
        return -1
    }

    var map_2 = HashMap<String, String>()
    map_2.put("key2", "value2")
    request.initMultipartPayload("abc-abc", "---test2---", map_2)
    var result_2 = request.getMultipartPayload().getHeaders()
    var header_2 = result_2["Content-Type"]
    if (!"multipart/abc-abc; boundary=\"---test2---\"".equals(header_2)) {
        println(header_2)
        return -1
    }
    if (!"value2".equals(result_2["key2"])) {
        return -1
    }

    return 0
}

// public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload)
// public func addBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload)
public func testRequest_12():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)

    var payload_1 = MultipartPayload("test1")
    // 设置BodyPartPayload子类 
    request.setBodyPartPayloadInMultipartPayload(payload_1)
    var result_1 = request.getMultipartPayload().getBodyParts()
    if (result_1.size != 1) {
        println(result_1.size)
        println("-----------------------0")
        return -1
    }
    var bodyPart_1 = result_1[0].getHeaders()
    var header_1 = bodyPart_1["Content-Type"]
    if (!"multipart/form-data; boundary=\"test1\"".equals(header_1)) {
        println(header_1)
        println("-----------------------1")
        return -1
    }

    var payload_2 = MultipartPayload("==test2==")
    // 再次设置会替换之前的内容
    request.setBodyPartPayloadInMultipartPayload(payload_2)
    var result_2 = request.getMultipartPayload().getBodyParts()
    if (result_2.size != 1) {
        println(result_2.size)
        println("-----------------------2")
        return -1
    }
    var bodyPart_2 = result_2[0].getHeaders()
    var header_2 = bodyPart_2["Content-Type"]
    if (!"multipart/form-data; boundary=\"==test2==\"".equals(header_2)) {
        println(header_2)
        println("-----------------------3")
        return -1
    }

    return 0
}


main() {
    var test_09 = testRequest_09()
    var test_10 = testRequest_10()
    var test_11 = testRequest_11()
    var test_12 = testRequest_12()

    var sum = test_09+test_10+test_11+test_12
    println(sum)
    println("test_09=${test_09}, test_10=${test_10}, test_11=${test_11}, test_12=${test_12}")
    return sum
}