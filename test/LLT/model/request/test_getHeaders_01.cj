// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*

public func testAddHeader_01():Int32 {
    let url: String = "http://test/test"
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, url)

    request.addHeader("header-name", "middle")
    request.addHeader("Header-Name", "last")
    request.addHeader("HEADER-NAME", "first")

    let map: HashMap<String, String> = request.getHeaders()
    if (map.size != 1) {
        println(1)
        return 1
    }

    let value: String = map["header-name"]
    if (value != "first") {
        println(2)
        return 2
    }
    return 0
}

public func testAddHeader_02():Int32 {
    let url: String = "http://test/test"
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, url)

    request.addHeader("HEADER-NAME", "first")
    request.addHeader("header-name", "middle")
    request.addHeader("Header-Name", "last")

    let map: HashMap<String, String> = request.getHeaders()
    if (map.size != 1) {
        println(3)
        return 3
    }

    let value: String = map["HEADER-NAME"]
    if (value != "last") {
        println(4)
        return 4
    }
    return 0
}


main() {
    var test_01 = testAddHeader_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testAddHeader_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}