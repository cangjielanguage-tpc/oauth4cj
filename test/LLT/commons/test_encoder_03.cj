
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){
    let plain: String = "!*'();:@&=+$,/?#[]"
    let encoded: String = "%21%2A%27%28%29%3B%3A%40%26%3D%2B%24%2C%2F%3F%23%5B%5D"

    let str2: String = OAuthEncoder.encode(plain)
    let str3: String = OAuthEncoder.decode(encoded)
    println("str2 == encoded: ${str2 == encoded}")
    println("str3 == plain: ${str3 == plain}")
    if (str2 != encoded) {
        println(1)
        return 1
    }
    if (str3 != plain) {
        println(2)
        return 2
    }
    return 0
}
