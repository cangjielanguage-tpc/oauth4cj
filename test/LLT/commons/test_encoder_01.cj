// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){
    let plain: String = "this is a test &^"
    let encoded: String = "this%20is%20a%20test%20%26%5E"

    let str2: String = OAuthEncoder.encode(plain)
    println("str2 == encoded: ${str2 == encoded}")
    if (str2 != encoded) {
        return 1
    }
    return 0
}
