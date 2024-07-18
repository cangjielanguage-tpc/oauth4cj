// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
public import oauth4cj.*

func testTokenRequestParams_01(): Int32 {
    var code: String = "200"
    var params: AccessTokenRequestParams = 
        AccessTokenRequestParams.create(code)
                                .setPKCECodeVerifier("abcd")
                                .setScope("scope")
    if (params.getCode() != code) {
        return -1
    }

    if (params.getPkceCodeVerifier().getOrThrow() != "abcd") {
        return -1
    }

    if (params.getScope().getOrThrow() != "scope") {
        return -1
    }

    return 0
}

func testTokenRequestParams_02(): Int32 {
    var code: String = "300"
    var params = AccessTokenRequestParams(code)
    var map = HashMap<String, String>()
    params.addExtraParameters(map)
    if (params.getExtraParameters().size != 0) {
        return -1
    }
    map.put("name1", "value1")
    map.put("name2", "value2")
    params.addExtraParameters(map)
    if (params.getExtraParameters().size != 2) {
        return -1
    }
    params.addExtraParameter("name3", "value3")
    params.addExtraParameter("name4", "value4")
    if (params.getExtraParameters().size != 4) {
        return -1
    }
    return 0
}

func testTokenRequestParams_03(): Int32 {
    var code: String = "400"
    var params = AccessTokenRequestParams(code)
    var map = HashMap<String, String>()
    map.put("name1", "value1")
    map.put("name2", "value2")
    params.addExtraParameters(map)
    if (params.getExtraParameters().size != 2) {
        return -1
    }
    var mapNone = HashMap<String, String>()
    params.setExtraParameters(mapNone)
    if (params.getExtraParameters().size != 0) {
        return -1
    }
    return 0
}

func testTokenRequestParams_04(): Int32 {
    var code: String = "500"
    var params = AccessTokenRequestParams(code)
    var scopes: Array<String> = Array<String>(["a", "b", "c"])
    var scope: ScopeBuilder = ScopeBuilder(scopes)
    scope.withScope("scope")
    var scopeString = "a b c scope"
    params.setScope(scope)
    if (params.getScope().getOrThrow() != scopeString) {
        return -1
    }
    return 0
}

main() {
    var test_01 = testTokenRequestParams_01()
    var test_02 = testTokenRequestParams_02()
    var test_03 = testTokenRequestParams_03()
    var test_04 = testTokenRequestParams_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}

