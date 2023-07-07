
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import commons.*

main (){
    let plain: String = "abcde123456-._~"
    let encoded: String = plain

    let str2: String = OAuthEncoder.encode(plain)
    println("str2 == encoded: ${str2 == encoded}")
    if (!str2.equals(encoded)) {
        return 1
    }
    return 0
}
