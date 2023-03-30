// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import utils.*

from std import io.*

main (){
    let str: String = "Hello World"
    let bytes: Array<UInt8> = str.toUtf8Array()
    let bas: ByteArrayStream = ByteArrayStream(526)
    bas.write(bytes)
    let decoded: String = StreamUtils.getStreamContents(bas)
    println("decoded == str: ${decoded == str}")
    if (!str.equals(decoded)) {
        println(1)
        return 1
    }
    return 0
}