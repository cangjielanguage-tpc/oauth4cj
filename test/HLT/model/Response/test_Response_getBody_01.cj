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
    func testResponseGetBody01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Closeable>([sub01]))
        for (str in strValues) {
            inputStream01=ByteArrayStream()
            inputStream01.write("hello byte".toUtf8Array())
            response01=Response(Int32(32),str,HashMap<String,String>(),str)
            response02=Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Closeable>([sub01]))
            @Assert(response01.getBody(),str)
            @Assert(response02.getBody(),"hello byte")
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