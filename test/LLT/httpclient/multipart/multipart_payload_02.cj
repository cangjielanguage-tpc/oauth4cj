// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

main() {

    var test_01 = testMultipartPayload_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testMultipartPayload_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartPayload_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testMultipartPayload_01(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    let mp: MultipartPayload = MultipartPayload(headers)

    let header: HashMap<String, String> = mp.getHeaders()
    let bodyParts: ArrayList<BodyPartPayload> = mp.getBodyParts()
    let boundary: String = mp.getBoundary()
    let preamble: String = mp.getPreamble()
    let epilogue: String = mp.getEpilogue()

    let str: String = "multipart/form-data; boundary=\"----OAuth4cj----"
    if (header.size != 1 ||  bodyParts.size != 0) {
        println(1)
        return 1
    }

    if (!header.contains(OAuthConstants.CONTENT_TYPE) || !header[OAuthConstants.CONTENT_TYPE].contains(str)) {
        println(2)
        return 2
    }
    if (!boundary.contains("----OAuth4cj----") || preamble != "" || epilogue != "") {
        println(3)
        return 3
    }
    return 0
}

public func testMultipartPayload_02(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    let mp: MultipartPayload = MultipartPayload("test", headers)

    let header: HashMap<String, String> = mp.getHeaders()
    let bodyParts: ArrayList<BodyPartPayload> = mp.getBodyParts()
    let boundary: String = mp.getBoundary()
    let preamble: String = mp.getPreamble()
    let epilogue: String = mp.getEpilogue()

    let str: String = "multipart/form-data; boundary=\"test\""
    if (header.size != 1 ||  bodyParts.size != 0) {
        println(4)
        return 4
    }
    if (!header.contains(OAuthConstants.CONTENT_TYPE) || !header[OAuthConstants.CONTENT_TYPE].contains(str)) {
        println(5)
        return 5
    }
    if (boundary != "test" || preamble != "" || epilogue != "") {
        println(6)
        return 6
    }
    return 0
}

public func testMultipartPayload_03(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    try {
        let mp: MultipartPayload = MultipartPayload("", headers)
        println(mp.getPreamble())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }

    println(7)
    return 7
}

