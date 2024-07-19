// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
public import oauth4cj.*

public func testPlaintextSignatureService_01(): Int32 {

    let ps: PlaintextSignatureService = PlaintextSignatureService()
    let str: String = ps.getSignatureMethod()
    let result: String = "PLAINTEXT"

    if (str != result) {
        println(1)
        return 1
    }

    return 0
}

public func testPlaintextSignatureService_02(): Int32 {
    let ps: PlaintextSignatureService = PlaintextSignatureService()
    let apiSecret: String = "awefla"
    let tokenSecret: String = "VAEW848235*3王者"

    let str: String = ps.getSignature("ceshi20230504", apiSecret, tokenSecret)

    let result: String = OAuthEncoder.encode(apiSecret) + "&" + OAuthEncoder.encode(tokenSecret)

    if (str != result) {
        println(2)
        return 2
    }

    return 0
}

main() {

    var test_01 = testPlaintextSignatureService_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testPlaintextSignatureService_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}