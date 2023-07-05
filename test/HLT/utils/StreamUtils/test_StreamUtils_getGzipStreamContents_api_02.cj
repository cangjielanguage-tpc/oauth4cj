// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import commons.*
from compress import zlib.*
from std import io.*

@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var gzipinput=CompressInputStream(input,wrap:GzipFormat)
    public var re="not empty"

 	//is有内容,返回字符串准确
    @TestCase
    func testGetGzipStreamContents02(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        gzipinput=CompressInputStream(input,wrap:GzipFormat)
        re=StreamUtils.getGzipStreamContents(gzipinput)   
        @Assert(re,str)
    }       
}