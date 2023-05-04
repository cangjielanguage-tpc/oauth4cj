// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
from std import io.*
@Test
public class TestStreamUtilsV001{
    public var input=ByteArrayStream()
    public var re="not empty"

 	//is有内容,返回字符串准确
    @TestCase
    func testGetStreamContents02(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        re=StreamUtils.getStreamContents(input)   
        @Assert(re,str)
    }
}