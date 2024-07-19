// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main () {
    var flag = 0
    try {
        var encoded_1 = URLEncoder.encode("", "")
        println(encoded_1.size)
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }
    try {
        var encoded_2 = URLEncoder.encode("abc", "GBK")
        println(encoded_2.size)
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }

    try {
        var decode_1 = URLEncoder.decode("", "")
        println(decode_1.size)
    } catch (ex: OAuth4cjException) {
        println(ex)
        flag ++
    }

    try {
        var decode_2 = URLEncoder.decode("abc", "GBK")
        println(decode_2.size)
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