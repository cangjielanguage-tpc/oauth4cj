// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.4.2 示例
public import oauth4cj.*

public func testHMACSha1SignatureService_01(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let str: String = hmac.getSignatureMethod()
    let result: String = "HMAC-SHA1"
	if(str!=result){
	    return 1
	}
	println("str = ${str}")
    return 0
}

public func testHMACSha1SignatureService_02(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = "api secret"
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"
    let signature: String = "uGymw2KHOTWI699YEaoi5xyLT50="
    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    if (str!=signature) {
        return 2
    }
    println("str = ${str}")
    return 0
}

main() {
    var test_01 = testHMACSha1SignatureService_01()
    if (test_01 != 0){
        return test_01
    }
    test_01 = testHMACSha1SignatureService_02()
    if (test_01 != 0){
        return test_01
    }
	println("ok!")
    return test_01
}