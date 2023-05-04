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
    //有header,其他
    @TestCase
    func testResponseGetBody0202(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream01,ArrayList<Closeable>([sub01]))
        var response03=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream02,ArrayList<Closeable>([sub01]))

        var encodingContent=Array<String>(["GZIP","Gzip","abgzip","gzip01","other"])
        for (encodeingValue in encodingContent){
            inputStream01=ByteArrayStream()
            inputStream01.write("hello byte".toUtf8Array())
            response01=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),"body")
            response02=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),inputStream01,ArrayList<Closeable>([sub01]))
            response03=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),inputStream02,ArrayList<Closeable>([sub01]))
        }

        @Assert(response01.getBody(),"body")
        @Assert(response02.getBody(),"hello byte")
        var exp_flag=0
        try{
            response03.getBody()
        }catch(e:Exception){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
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