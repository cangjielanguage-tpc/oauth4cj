// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){
    let bytes: Array<UInt8> = "Hello World\r\nNew Line2".toArray()
    let encoded: String = "SGVsbG8gV29ybGQNCk5ldyBMaW5lMg=="
    let str: String = Base64Utils.encode(bytes)
    println("encoded == str: ${encoded == str}")
    if (str != encoded) {
        println(1)
        return 1
    }
    return 0
}
