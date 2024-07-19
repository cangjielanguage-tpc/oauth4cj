// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){
    if (testGetSanitizedUrl_01() != 0) {
        println(1)
        return 1
    }
    if (testGetSanitizedUrl_02() != 0) {
        println(2)
        return 2
    }
    if (testGetSanitizedUrl_03() != 0) {
        println(3)
        return 3
    }
    if (testGetSanitizedUrl_04() != 0) {
        println(4)
        return 4
    }

    if (testGetSanitizedUrl_05() != 0) {
        println(5)
        return 5
    }
    if (testGetSanitizedUrl_06() != 0) {
        println(6)
        return 6
    }
    if (testGetSanitizedUrl_07() != 0) {
        println(7)
        return 7
    }
    if (testGetSanitizedUrl_08() != 0) {
        println(8)
        return 8
    }

    if (testGetSanitizedUrl_09() != 0) {
        println(9)
        return 9
    }
    if (testGetSanitizedUrl_10() != 0) {
        println(10)
        return 10
    }
    if (testGetSanitizedUrl_11() != 0) {
        println(11)
        return 11
    }
    if (testGetSanitizedUrl_12() != 0) {
        println(12)
        return 12
    }

    if (testGetSanitizedUrl_13() != 0) {
        println(13)
        return 13
    }
    if (testGetSanitizedUrl_14() != 0) {
        println(14)
        return 14
    }

    return 0
}

func testGetSanitizedUrl_01(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1:80"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_02(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1:80\\"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_03(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = ""
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_04(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1:80"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_05(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:443/?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1:443/"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_06(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "abc\\?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "abc\\"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_07(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "\\?abc\\?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "\\"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_08(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "abc\\123\\?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "abc\\123\\"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_09(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, ":443http://127.0.0.1:80:80:443")
    let str: String = request.getSanitizedUrl()

    let res: String = ":443http://127.0.0.1:80:80:443"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_10(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80:80:443")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1:80:80:443"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_11(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80:80/?.*abc123")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1/"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_12(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80:80/abc123\\?.*abc456")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1/abc123\\"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_13(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "http://127.0.0.1:80:80/abc123?.abc456")
    let str: String = request.getSanitizedUrl()

    let res: String = "http://127.0.0.1/abc123"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}

func testGetSanitizedUrl_14(): Int32 {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, "https://127.0.0.1:443/?.*name=xiaoli&\\?.*")
    let str: String = request.getSanitizedUrl()

    let res: String = "https://127.0.0.1/"
    println("res == str: ${res == str}")
    if (str != res) {
        return 1
    }
    return 0
}
