// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.2.2 示例
from oauth4cj import oauth4cj.*
from std import io.*
main (){
    let str: String = "Hello World"
    let bytes: Array<UInt8> = str.toUtf8Array()
    let bas: ByteArrayStream = ByteArrayStream(526)
    bas.write(bytes)
    let decoded: String = StreamUtils.getStreamContents(bas)
    if(decoded == str){
        println("decoded == str: ${decoded == str}")
        return 0
    }
    return 1
}