// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.1.2 示例
public import oauth4cj.*
main(): Int64 {
    let bytes: Array<UInt8> = "Hello World".toArray()
    let encoded: String = "SGVsbG8gV29ybGQ="
    let str: String = Base64Utils.encode(bytes)
    if(encoded == str){
        println("encoded == str: ${encoded == str}")
        return 0
    }
    return 1
}