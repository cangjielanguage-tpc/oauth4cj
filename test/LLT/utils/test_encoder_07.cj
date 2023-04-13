// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import utils.*
from oauth4cj import exceptions.*

main () {
    var flag = 0
    try {
        var encoded_1 = URLEncoder.encode("", "")
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }
    try {
        var encoded_2 = URLEncoder.encode("abc", "GBK")
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }

    try {
        var decode_1 = URLEncoder.decode("", "")
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }

    try {
        var decode_2 = URLEncoder.decode("abc", "GBK")
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }

    println("flag = ${flag}")
    if (flag != 4) {
        return -1
    }
    return 0
}