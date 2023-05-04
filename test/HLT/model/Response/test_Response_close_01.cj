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
    func testResponseClose01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var file=File("common_Values.cj",OpenOption.CreateOrTruncate(true))
        var sub01=SubCloseable(file)
        var inputStream01=ByteArrayStream()
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Closeable>([sub01]))
        response01.close()
        @Assert(file.isClosed(),false)
        try{
            response02.close()
            @Assert(file.isClosed(),true)
        }catch(e:FSException){
            println("关闭异常")
            @Assert(file.isClosed(),false)
        }
   }
}

public class SubCloseable <: Closeable{
    public var file=File("newFile.txt",OpenOption.CreateOrTruncate(true))
    public init(file:File){
        this.file=file
    }
    public func close(){
        this.file.close()
    }
}