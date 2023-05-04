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
    //stream的几种情况,构造器是否传入以及传入是否为空
    @TestCase
    func testResponseGetStream01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello byte".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))
        var response03=Response(Int32(2),"message",HashMap<String,String>(),ByteArrayStream(),ArrayList<Closeable>([sub01]))
        for (str in strValues) {
            inputStream=ByteArrayStream()
            inputStream.write("hello byte".toUtf8Array())
            response01=Response(Int32(32),str,HashMap<String,String>(),str)
            response02=Response(Int32(32),str,HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))
            response03=Response(Int32(32),str,HashMap<String,String>(),ByteArrayStream(),ArrayList<Closeable>([sub01]))
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response01.getStream())),"")
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response02.getStream())),"hello byte")
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response03.getStream())),"")
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

public func getDataArrayFromInputStream(input:InputStream):Array<UInt8>{
     var read=1
     var outbuf_temp=Array<UInt8>(1024,item:0)
     var outbuf_arrlist=ArrayList<UInt8>()
     while(read>0){
         read=input.read(outbuf_temp)
         if(read!=0){
             outbuf_arrlist.appendAll(outbuf_temp[0..read])
         }
     }
     var out_final=Array<UInt8>(outbuf_arrlist)
     return out_final
}