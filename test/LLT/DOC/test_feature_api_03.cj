// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.3.2 示例
public import oauth4cj.*
import std.collection.HashMap
import std.collection.ArrayList
import std.io.*

main (){
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Resource> = ArrayList<Resource>()
    stream.write("abcdefg".toArray()) // 向流中写入测试数据
    var response:OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, stream, closeables)
    var responseStream = response.getStream()
    var buffer:Array<Byte> = Array<Byte>(7, item:0)
    responseStream.read(buffer)
    var str_1 = String.fromUtf8(buffer)
    var str_2:String = response.toString()
    if ("abcdefg"!=str_1){
       return -1
    }
    println(str_1)
    if ("Response{code=200, message='message', body='', headers=[]}" !=str_2){
       return -2
    }
    println(str_2)
    return 0
}