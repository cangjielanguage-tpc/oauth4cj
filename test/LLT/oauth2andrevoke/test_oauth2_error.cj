// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

func testOAuth2Error_01(): Int32 {
    var string_1 = OAuth2Error.INVALID_REQUEST.getErrorString()
    var string_2 = OAuth2Error.UNAUTHORIZED_CLIENT.getErrorString()
    var string_3 = OAuth2Error.ACCESS_DENIED.getErrorString()
    var string_4 = OAuth2Error.UNSUPPORTED_RESPONSE_TYPE.getErrorString()
    var string_5 = OAuth2Error.INVALID_SCOPE.getErrorString()

    if (string_1 != "invalid_request") {
        return -1
    }
    if (string_2 != "unauthorized_client") {
        return -1
    }
    if (string_3 != "access_denied") {
        return -1
    }
    if (string_4 != "unsupported_response_type") {
        return -1
    }
    if (string_5 != "invalid_scope") {
        return -1
    }

    if (string_1 != OAuth2Error.parseFrom("invalid_request").getErrorString()) {
        return -1
    }
    if (string_2 != OAuth2Error.parseFrom("unauthorized_client").getErrorString()) {
        return -1
    }
    if (string_3 != OAuth2Error.parseFrom("access_denied").getErrorString()) {
        return -1
    }
    if (string_4 != OAuth2Error.parseFrom("unsupported_response_type").getErrorString()) {
        return -1
    }
    if (string_5 != OAuth2Error.parseFrom("invalid_scope").getErrorString()) {
        return -1
    }
    
    return 0
}
 
func testOAuth2Error_02(): Int32 {
    var string_6 = OAuth2Error.SERVER_ERROR.getErrorString()
    var string_7 = OAuth2Error.TEMPORARILY_UNAVAILABLE.getErrorString()
    var string_8 = OAuth2Error.INVALID_CLIENT.getErrorString()
    var string_9 = OAuth2Error.INVALID_GRANT.getErrorString()
    var string_10 = OAuth2Error.UNSUPPORTED_GRANT_TYPE.getErrorString()
    
    if (string_6 != "server_error") {
        return -1
    }
    if (string_7 != "temporarily_unavailable") {
        return -1
    }
    if (string_8 != "invalid_client") {
        return -1
    }
    if (string_9 != "invalid_grant") {
        return -1
    }
    if (string_10 != "unsupported_grant_type") {
        return -1
    }

    if (string_6 != OAuth2Error.parseFrom("server_error").getErrorString()) {
        return -1
    }
    if (string_7 != OAuth2Error.parseFrom("temporarily_unavailable").getErrorString()) {
        return -1
    }
    if (string_8 != OAuth2Error.parseFrom("invalid_client").getErrorString()) {
        return -1
    }
    if (string_9 != OAuth2Error.parseFrom("invalid_grant").getErrorString()) {
        return -1
    }
    if (string_10 != OAuth2Error.parseFrom("unsupported_grant_type").getErrorString()) {
        return -1
    }

    return 0
}

func testOAuth2Error_03(): Int32 {
    var string_11 = OAuth2Error.INVALID_TOKEN.getErrorString()
    var string_12 = OAuth2Error.INSUFFICIENT_SCOPE.getErrorString()
    var string_13 = OAuth2Error.UNSUPPORTED_TOKEN_TYPE.getErrorString()
    var string_14 = OAuth2Error.AUTHORIZATION_PENDING.getErrorString()
    var string_15 = OAuth2Error.SLOW_DOWN.getErrorString()
    var string_16 = OAuth2Error.EXPIRED_TOKEN.getErrorString()

    if (string_11 != "invalid_token") {
        return -1
    }
    if (string_12 != "insufficient_scope") {
        return -1
    }
    if (string_13 != "unsupported_token_type") {
        return -1
    }
    if (string_14 != "authorization_pending") {
        return -1
    }
    if (string_15 != "slow_down") {
        return -1
    }
    if (string_16 != "expired_token") {
        return -1
    }


    if (string_11 != OAuth2Error.parseFrom("invalid_token").getErrorString()) {
        return -1
    }
    if (string_12 != OAuth2Error.parseFrom("insufficient_scope").getErrorString()) {
        return -1
    }
    if (string_13 != OAuth2Error.parseFrom("unsupported_token_type").getErrorString()) {
        return -1
    }
    if (string_14 != OAuth2Error.parseFrom("authorization_pending").getErrorString()) {
        return -1
    }
    if (string_15 != OAuth2Error.parseFrom("slow_down").getErrorString()) {
        return -1
    }

    if (string_16 != OAuth2Error.parseFrom("expired_token").getErrorString()) {
        return -1
    }

    return 0
}

func testOAuth2Error_04(): Int32 {
    try {
        OAuth2Error.parseFrom("AAA")
        return -1
    } catch (e: IllegalArgumentException) {
        println(e)
        return 0
    }
}


main() {
    var test_01 = testOAuth2Error_01()
    var test_02 = testOAuth2Error_02()
    var test_03 = testOAuth2Error_03()
    var test_04 = testOAuth2Error_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}