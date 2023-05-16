// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*

main() {

    var test_01 = testByteArrayBodyPartPayload_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testByteArrayBodyPartPayload_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testByteArrayBodyPartPayload_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testByteArrayBodyPartPayload_01(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>()
    let bp: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(payload, 0, 0, "")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    if (headers.size != 0 || arr.size != 0 || off != 0 || len != 0) {
        println(1)
        return 1
    }
    return 0
}

public func testByteArrayBodyPartPayload_02(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>()
    let bp: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(payload, 0, 0)
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    if (headers.size != 0 || arr.size != 0 || off != 0 || len != 0) {
        println(2)
        return 2
    }
    return 0
}

public func testByteArrayBodyPartPayload_03(): Int32 {
    let payload: Array<UInt8> = Array<UInt8>([95, 96, 97])
    let bp: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(payload, "test")
    let headers: HashMap<String, String> = bp.getHeaders()
    let arr: Array<UInt8> = bp.getPayload()
    let off: Int64 = bp.getOff()
    let len: Int64 = bp.getLen()
    if (headers.size != 1 || !headers.contains(CONTENT_TYPE) || !headers[CONTENT_TYPE].equals("test")) {
        println(3)
        return 3
    }
    if (arr.size != 3 || off != 0 || len != 3) {
        println(4)
        return 4
    }
    return 0
}
