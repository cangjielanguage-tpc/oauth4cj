// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*

main() {

    var test_01 = testFileByteArrayBodyPartPayload_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testFileByteArrayBodyPartPayload_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testFileByteArrayBodyPartPayload_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testFileByteArrayBodyPartPayload_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testFileByteArrayBodyPartPayload_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testFileByteArrayBodyPartPayload_06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testFileByteArrayBodyPartPayload_01(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>()
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload(payload, 0, 0, "", "")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"\"; filename=\"\""
    if (headers.size != 1 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(1)
        return 1
    }
    if (arr.size != 0 || off != 0 || len != 0) {
        println(2)
        return 2
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_02(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload(payload, 1, 2, "name_test", "filename_test")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"name_test\"; filename=\"filename_test\""
    if (headers.size != 1 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(3)
        return 3
    }
    if (arr.size != 3 || off != 1 || len != 2) {
        println(4)
        return 4
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_03(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload("contentType_test", payload)
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data"
    if (headers.size != 2 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(5)
        return 5
    }
    if (!headers.contains(CONTENT_TYPE) || !headers[CONTENT_TYPE].equals("contentType_test")) {
        println(51)
        return 51
    }
    if (arr.size != 3 || off != 0 || len != 3) {
        println(6)
        return 6
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_04(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>()
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload("", payload)
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data"
    if (headers.size != 2 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(7)
        return 7
    }
    if (!headers.contains(CONTENT_TYPE) || !headers[CONTENT_TYPE].isEmpty()) {
        println(71)
        return 71
    }
    if (arr.size != 0 || off != 0 || len != 0) {
        println(8)
        return 8
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_05(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload("contentType_test", payload, 1, 2)
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data"
    if (headers.size != 2 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(9)
        return 9
    }
    if (!headers.contains(CONTENT_TYPE) || !headers[CONTENT_TYPE].equals("contentType_test")) {
        println(91)
        return 91
    }
    if (arr.size != 3 || off != 1 || len != 2) {
        println(10)
        return 10
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_06(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>()
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload("", payload, "")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"\""
    if (headers.size != 2 || !headers.contains("Content-Disposition") || !headers["Content-Disposition"].equals(str)) {
        println(11)
        return 11
    }
    if (!headers.contains(CONTENT_TYPE) || !headers[CONTENT_TYPE].isEmpty()) {
        println(111)
        return 111
    }
    if (arr.size != 0 || off != 0 || len != 0) {
        println(12)
        return 12
    }
    return 0
}
