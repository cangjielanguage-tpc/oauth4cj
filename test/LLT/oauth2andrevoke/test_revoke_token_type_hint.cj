// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import revoke.*

func testTokenTypeHint_01(): Int32 {
    if ("access_token_hint".equals(TokenTypeHint.ACCESS_TOKEN_HINT.getValue())) {
        return 0
    } else {
        return -1
    }
}

func testTokenTypeHint_02(): Int32 {
    if ("refresh_token_hint".equals(TokenTypeHint.REFRESH_TOKEN_HINT.getValue())) {
        return 0
    } else {
        return -1
    }
}

main() {
    var test_01 = testTokenTypeHint_01()
    var test_02 = testTokenTypeHint_02()

    var sum = test_01+test_02
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}")
    return sum
}