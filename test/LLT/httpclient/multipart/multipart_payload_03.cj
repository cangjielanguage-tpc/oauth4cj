// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*

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
    test_01 = testMultipartPayload_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartPayload_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testMultipartPayload_01(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put(CONTENT_TYPE, "")
    let mp: MultipartPayload = MultipartPayload(headers)

    let header: HashMap<String, String> = mp.getHeaders()
    let bodyParts: ArrayList<BodyPartPayload> = mp.getBodyParts()
    let boundary: String = mp.getBoundary()
    let preamble: String = mp.getPreamble()
    let epilogue: String = mp.getEpilogue()

    let str: String = "; boundary=\"----OAuth4cj----"
    if (header.size != 1 ||  bodyParts.size != 0) {
        println(1)
        return 1
    }
    if (!header.contains(CONTENT_TYPE) || !header[CONTENT_TYPE].contains(str)) {
        println(2)
        return 2
    }
    if (!boundary.contains("----OAuth4cj----") || !preamble.equals("") || !epilogue.equals("")) {
        println(3)
        return 3
    }
    return 0
}

public func testMultipartPayload_02(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put(CONTENT_TYPE, "")
    let mp: MultipartPayload = MultipartPayload(headers)

    let header: HashMap<String, String> = mp.getHeaders()
    let bodyParts: ArrayList<BodyPartPayload> = mp.getBodyParts()
    let boundary: String = mp.getBoundary()
    let preamble: String = mp.getPreamble()
    let epilogue: String = mp.getEpilogue()

    let str: String = "; boundary=\"----OAuth4cj----"
    if (header.size != 1 ||  bodyParts.size != 0) {
        println(4)
        return 4
    }
    println(header.contains(CONTENT_TYPE))
    println(header[CONTENT_TYPE])
    println(header[CONTENT_TYPE].contains(str))
    if (!header.contains(CONTENT_TYPE) || !header[CONTENT_TYPE].contains(str)) {
        println(5)
        return 5
    }
    if (!boundary.contains("----OAuth4cj----") || !preamble.equals("") || !epilogue.equals("")) {
        println(6)
        return 6
    }
    return 0
}

public func testMultipartPayload_03(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put(CONTENT_TYPE, "test")
    let mp: MultipartPayload = MultipartPayload(headers)

    let header: HashMap<String, String> = mp.getHeaders()
    let bodyParts: ArrayList<BodyPartPayload> = mp.getBodyParts()
    let boundary: String = mp.getBoundary()
    let preamble: String = mp.getPreamble()
    let epilogue: String = mp.getEpilogue()

    let str: String = "test; boundary=\"----OAuth4cj----"
    if (header.size != 1 ||  bodyParts.size != 0) {
        println(7)
        return 7
    }

    if (!header.contains(CONTENT_TYPE) || !header[CONTENT_TYPE].contains(str)) {
        println(8)
        return 8
    }
    if (!boundary.contains("----OAuth4cj----") || !preamble.equals("") || !epilogue.equals("")) {
        println(9)
        return 9
    }
    return 0
}

public func testMultipartPayload_04(): Int32 {
    let headers: HashMap<String, String> = HashMap<String, String>()
    try {
        let mp: MultipartPayload = MultipartPayload("boundary", headers)
        let mp2: MultipartPayload = MultipartPayload("boundary", headers)
        mp.addBodyPart(mp2)
    } catch (e: IllegalArgumentException) {
        e.printStackTrace()
        return 0
    }

    println(10)
    return 10
}

public func testMultipartPayload_05(): Int32 {
    try {
        let mp: MultipartPayload = MultipartPayload("~~test1~~")
    } catch (e: IllegalArgumentException) {
        e.printStackTrace()
        return 0
    }

    println(11)
    return 11
}

