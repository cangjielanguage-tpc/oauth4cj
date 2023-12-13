
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

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
    return test_01
}

public func testFileByteArrayBodyPartPayload_01(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload(
            "contentType_test", payload, 1, 2, "name_test")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"name_test\""
    if (headers.size != 2 || !headers.contains("Content-Disposition") || headers["Content-Disposition"] != str) {
        println(1)
        return 1
    }
    if (!headers.contains(OAuthConstants.CONTENT_TYPE) || headers[OAuthConstants.CONTENT_TYPE] != "contentType_test") {
        println(11)
        return 11
    }
    if (arr.size != 3 || off != 1 || len != 2) {
        println(2)
        return 2
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_02(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload(
            "contentType_test", payload, "name_test", "filename_test")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"name_test\"; filename=\"filename_test\""
    if (headers.size != 2 || !headers.contains("Content-Disposition") ||
            headers["Content-Disposition"] != str) {
        println(3)
        return 3
    }
    if (!headers.contains(OAuthConstants.CONTENT_TYPE) || headers[OAuthConstants.CONTENT_TYPE] != "contentType_test") {
        println(4)
        return 4
    }
    if (arr.size != 3 || off != 0 || len != 3) {
        println(5)
        return 5
    }
    return 0
}

public func testFileByteArrayBodyPartPayload_03(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: FileByteArrayBodyPartPayload = FileByteArrayBodyPartPayload(
            "contentType_test", payload, 6, 9, "name_test", "filename_test")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    let str: String = "form-data; name=\"name_test\"; filename=\"filename_test\""
    if (headers.size != 2 || !headers.contains("Content-Disposition") || headers["Content-Disposition"] != str) {
        println(6)
        return 6
    }
    if (!headers.contains(OAuthConstants.CONTENT_TYPE) || headers[OAuthConstants.CONTENT_TYPE] != "contentType_test") {
        println(7)
        return 7
    }
    if (headers.size != 2 || arr.size != 3 || off != 6 || len != 9) {
        println(8)
        return 8
    }
    return 0
}
