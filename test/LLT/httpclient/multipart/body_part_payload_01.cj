// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

main() {

    var test_01 = testBodyPartPayload_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testBodyPartPayload_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testBodyPartPayload_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testBodyPartPayload_01(): Int32 {
    let bp: BodyPartPayload = BodyPartPayload()
    let headers: HashMap<String, String> = bp.getHeaders()
    if (headers.size != 0) {
        println(1)
        return 1
    }
    return 0
}

public func testBodyPartPayload_02(): Int32 {
    let bp: BodyPartPayload = BodyPartPayload("")
    let headers: HashMap<String, String> = bp.getHeaders()
    if (headers.size != 0) {
        println(2)
        return 2
    }
    return 0
}

public func testBodyPartPayload_03(): Int32 {
    let bp: BodyPartPayload = BodyPartPayload("test")
    let headers: HashMap<String, String> = bp.getHeaders()
    if (headers.size != 1 || !headers.contains(OAuthConstants.CONTENT_TYPE) || !headers[OAuthConstants.CONTENT_TYPE].equals("test")) {
        println(3)
        return 3
    }
    return 0
}
