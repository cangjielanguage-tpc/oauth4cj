// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
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
from compress import zlib.*
@Test
public class TestResponseV001{
    //有header,header包含key：Content-Encoding,且value为“gzip”
    @TestCase
    func testResponseGetBody02(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        inputStream02.write("hello byte".toUtf8Array())
        var gzipinput=CompressInputStream(inputStream01,wrap:GzipFormat)
        var response02=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),gzipinput,ArrayList<Resource>([sub01]))
        var response03=Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream02,ArrayList<Resource>([sub01]))
        var exp_flag=0
        try{
           response03.getBody()
        }catch(e:Exception){
           if(e.toString().contains(" Decompressing data error")){
                exp_flag=1
           }
        }
        @Assert(exp_flag,1)
        @Assert(response01.getBody(),"body")
        @Assert(response02.getBody(),"hello byte")
    }
}

public class SubCloseable <: Resource{
    public var file=File("newFile.txt",OpenOption.CreateOrTruncate(true))
    public static var flagClose=false
    public init(file:File){
        this.file=file
    }
    public func close(){
        this.file.close()
        flagClose=true
    }
    public func isClosed(): Bool { return false }
}