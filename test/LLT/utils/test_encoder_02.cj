// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import utils.*

main (){
    let plain: String = "this is a test &^"
    let encoded: String = "this+is+a+test+%26%5E"

    let str2: String = OAuthEncoder.decode(encoded)
    println("str2 == plain: ${str2 == plain}")
    if (!str2.equals(plain)) {
        return 1
    }
    return 0
}
