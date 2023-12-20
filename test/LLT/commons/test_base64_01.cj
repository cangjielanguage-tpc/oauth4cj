// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

main (){
    let bytes: Array<UInt8> = "Hello World".toArray()
    let encoded: String = "SGVsbG8gV29ybGQ="
    let str: String = Base64Utils.encode(bytes)
    println("encoded == str: ${encoded == str}")
    if (str != encoded) {
        println(1)
        return 1
    }
    return 0
}
