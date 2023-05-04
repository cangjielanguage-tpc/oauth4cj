// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
from std import math.*
from std import fs.*
@Test
public class TestResponseV001{
    //无header
    @TestCase
    func testResponsetoString01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        inputStream01.write("hello world".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Closeable>([sub01]))

        for (str in strValues) {
            response01=Response(Int32(32),str,HashMap<String,String>(),str)
            inputStream01.write("hello world".toUtf8Array())
            response02=Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Closeable>([sub01]))
            var tostring_response01="Response{"+ "code=" + response01.getCode().toString()+ ", message='" + response01.getMessage() + '\'' + ", body='" + response01.getBody() + '\''+ ", headers=" + response01.getHeaders().toString() + "}"
            var tostring_response02="Response{"+ "code=" + response02.getCode().toString()+ ", message='" + response02.getMessage() + '\'' + ", body='" + response02.getBody() + '\''+ ", headers=" + response02.getHeaders().toString() + "}"
            @Assert(response01.toString(),tostring_response01)
            @Assert(response02.toString(),tostring_response02)
        }
    }
}

public class SubCloseable <: Closeable{
    public var file=File("newFile.txt",OpenOption.CreateOrTruncate(true))
    public static var flagClose=false
    public init(file:File){
        this.file=file
    }
    public func close(){
        this.file.close()
        flagClose=true
    }
}