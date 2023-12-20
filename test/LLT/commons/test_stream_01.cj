// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

from std import io.*

main (){
    let str: String = "Hello World"
    let bytes: Array<UInt8> = str.toArray()
    let bas: ByteArrayStream = ByteArrayStream(526)
    bas.write(bytes)
    let decoded: String = StreamUtils.getStreamContents(bas)
    println("decoded == str: ${decoded == str}")
    if (str != decoded) {
        println(1)
        return 1
    }
    return 0
}
