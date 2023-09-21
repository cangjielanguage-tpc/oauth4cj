// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

from compress import zlib.*
from std import io.*
from std import collection.*

main (){

    let test_01: String = testGetGzipStreamContents_01()
    let test_02: String = testGetGzipStreamContents_02()
    let test_03: String = testGetGzipStreamContents_03()
    println("test_01 = " + test_01)
    println("test_02 = " + test_02)
    println("test_03 = " + test_03)
    if (test_01 != test_02 && test_02 != test_03){
        println(1)
        return 1
    }

    return 0
}
//将压缩好的数组，存入ByteArrayStream，调用getGzipStreamContents函数
public func testGetGzipStreamContents_01(): String {
    var input = ByteArrayStream()
    var str = "hello cangjie"
    var arr = str.toUtf8Array()
    input.write(arr)
    var gzipinput = CompressInputStream(input, wrap:GzipFormat)
    var outbuf = Array<UInt8>(100,item:0)
    var outarrlist = ArrayList<Byte>()
    var read = 1
    while(read > 0){
        read = gzipinput.read(outbuf)
        outarrlist.appendAll(outbuf[0..read])
    }
    gzipinput.close()
    //压缩好的数组
    var outarr = Array<UInt8>(outarrlist)
    var input2 = ByteArrayStream()
    input2.write(outarr)
    var re = StreamUtils.getGzipStreamContents(input2)
    println("re = ${re}")

    return re
}

//将信息存入CompressInputStream中，调用getGzipStreamContents函数
public func testGetGzipStreamContents_02(): String {
    var input = ByteArrayStream()
    var str = "hello cangjie"
    var arr = str.toUtf8Array()
    input.write(arr)
    var gzipinput = CompressInputStream(input, wrap:GzipFormat)
    var re = StreamUtils.getGzipStreamContents(gzipinput)
    println("re = ${re}")

    return re
}

//直接CompressInputStream和CompressInputStream进行压缩解压缩对比
public func testGetGzipStreamContents_03(): String {
    var input = ByteArrayStream()
    var str = "hello cangjie"
    var arr = str.toUtf8Array()
    input.write(arr)
    var gzipinput = CompressInputStream(input, wrap:GzipFormat)
    var outbuf = Array<UInt8>(100,item:0)
    var outarrlist = ArrayList<Byte>()
    var read = 1
    while(read > 0){
        read = gzipinput.read(outbuf)
        outarrlist.appendAll(outbuf[0..read])
    }
    //压缩好的数组
    var outarr = Array<UInt8>(outarrlist)
    var input2 = ByteArrayStream()
    input2.write(outarr)

    var gzipoutput = DecompressInputStream(input2, wrap:GzipFormat)
    read = gzipoutput.read(outbuf)

    let result: String = String.fromUtf8(outbuf[0..read])
    println("result = ${result}")

    return result
}
