// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import services.*
from oauth4cj import commons.*

public func testHMACSha1SignatureService_01(): Int32 {

    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let str: String = hmac.getSignatureMethod()
    let result: String = "HMAC-SHA1"

    if (!str.equals(result)) {
        println(1)
        return 1
    }

    return 0
}

public func testHMACSha1SignatureService_02(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = "api secret"
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"
    
    let signature: String = "uGymw2KHOTWI699YEaoi5xyLT50="
    
    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")
    
    if (!str.equals(signature)) {
        println(2)
        return 2
    }

    return 0
}

public func testHMACSha1SignatureService_03(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = ""
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"

    let signature: String = "qs1UKi+6UdsEKtoCdydgyI7gGK8="

    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")

    if (!str.equals(signature)) {
        println(3)
        return 3
    }

    return 0
}

public func testHMACSha1SignatureService_04(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = ""
    let tokenSecret: String = ""
    let baseString: String = "base string"

    let signature: String = "pVyweW68bCMs3WHqGMDT6Swv9ZA="

    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")

    if (!str.equals(signature)) {
        println(4)
        return 4
    }

    return 0
}

public func testHMACSha1SignatureService_05(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = ""
    let tokenSecret: String = " "
    let baseString: String = "base string"

    let signature: String = "+g8LQp2xJPjoCoogkahA32qSIL0="

    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")

    if (!str.equals(signature)) {
        println(5)
        return 5
    }

    return 0
}

public func testHMACSha1SignatureService_06(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = " "
    let tokenSecret: String = " "
    let baseString: String = "base string"

    let signature: String = "E5D3ryCuHc1yOjC1pdqFvTFUcRE="

    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")

    if (!str.equals(signature)) {
        println(6)
        return 6
    }

    return 0
}

public func testHMACSha1SignatureService_07(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = " "
    let tokenSecret: String = " "
    let baseString: String = ""

    try {
        let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    } catch (e: Exception) {
        e.printStackTrace()
        return 0
    }

    return 7
}

public func testHMACSha1SignatureService_08(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = " "
    let tokenSecret: String = " "
    let baseString: String = " "

    try {
        let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    } catch (e: Exception) {
        e.printStackTrace()
        return 0
    }

    return 8
}

main() {

    var test_01 = testHMACSha1SignatureService_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testHMACSha1SignatureService_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testHMACSha1SignatureService_06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_07()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_08()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}