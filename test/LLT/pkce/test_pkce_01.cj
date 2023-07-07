// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import pkce.*

from encoding import base64.*
from oauth4cj import commons.*

// public init()  public func setCodeChallenge(codeChallenge: String) public func getCodeChallenge()
public func testPKCE_01():Int32 {
    var pk_1 = PKCE()
    if (!"".equals(pk_1.getCodeChallenge())){ 
        return -1
    }

    var codeChallenge:String = "a+b-c*d/e……f(g"
    pk_1.setCodeChallenge(codeChallenge)
    if (!codeChallenge.equals(pk_1.getCodeChallenge())){ 
        return -1
    }
    return 0
}

// getCodeChallengeMethod()  setCodeChallengeMethod(codeChallengeMethod: PKCECodeChallengeMethod)
public func testPKCE_02():Int32 {
    var pk_1 = PKCE()
    if (!"S256".equals(pk_1.getCodeChallengeMethod().toString())){ 
        return -1
    }

    pk_1.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
    if (!"PLAIN".equals(pk_1.getCodeChallengeMethod().toString())){ 
        return -1
    }
    return 0
}

// getCodeVerifier()  setCodeVerifier(codeVerifier: String)
public func testPKCE_03():Int32 {
    var pk_1 = PKCE()
    if (!"".equals(pk_1.getCodeVerifier())){ 
        return -1
    }

    var codeVerifier:String = "a+b-c*d/e……f(g"
    pk_1.setCodeVerifier(codeVerifier)
    if (!codeVerifier.equals(pk_1.getCodeVerifier())){ 
        return -1
    }
    return 0
}

// getAuthorizationUrlParams()
public func testPKCE_04():Int32 {
    var pk_1 = PKCE()
    var map = pk_1.getAuthorizationUrlParams()
    if (map.size != 2) {
        return -1
    }
    var value_1 = map[PKCE.PKCE_CODE_CHALLENGE_PARAM]
    var value_2 = map[PKCE.PKCE_CODE_CHALLENGE_METHOD_PARAM]
    if (!"".equals(value_1)) {
        return -1
    }
    if (!"S256".equals(value_2)) {
        return -1
    }

    return 0
}

// getAuthorizationUrlParams()
public func testPKCE_05():Int32 {
    var pk_1 = PKCE()
    var codeChallenge = "123456!@#%%$#"
    pk_1.setCodeChallenge(codeChallenge)
    pk_1.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)

    var map = pk_1.getAuthorizationUrlParams()
    if (map.size != 2) {
        return -1
    }
    var value_1 = map[PKCE.PKCE_CODE_CHALLENGE_PARAM]
    var value_2 = map[PKCE.PKCE_CODE_CHALLENGE_METHOD_PARAM]
    if (!codeChallenge.equals(value_1)) {
        return -1
    }
    if (!"PLAIN".equals(value_2)) {
        return -1
    }

    return 0
}

main() {
    var test_01 = testPKCE_01()
    var test_02 = testPKCE_02()
    var test_03 = testPKCE_03()
    var test_04 = testPKCE_04()
    var test_05 = testPKCE_05()

    var sum = test_01+test_02+test_03+test_04+test_05
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}, test_05=${test_05}")
    return sum
}