// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import commons.*
from oauth4cj import exceptions.*

main () {
    var flag = false
    var encoded_1 = OAuthEncoder.encode("")
    if (!"".equals(encoded_1)) {
        return -1
    }

    var decode_1 = OAuthEncoder.decode("")
    if (!"".equals(decode_1)) {
        return -1
    }

    // encode 的 OAuth4cjException异常触发不到
    try {
        var decode_2 = OAuthEncoder.decode("%%")
        println(decode_2.size)
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag = true
    }

    println("flag = ${flag}")
    if (!flag) {
        return -1
    }
    return 0
}