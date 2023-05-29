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
@Test
public class TestResponseV001{
    @TestCase
    func testResponseGetMessage01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
        var response03=Response(Int32(2),"message",HashMap<String,String>(),inputStream02,ArrayList<Resource>([sub01]))

        for (str in strValues) {
            response01=Response(Int32(32),str,HashMap<String,String>(),str)
            response02=Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
            response03=Response(Int32(32),str,HashMap<String,String>(),inputStream02,ArrayList<Resource>([sub01]))
            @Assert(response01.getMessage(),str)
            @Assert(response02.getMessage(),str)
            @Assert(response03.getMessage(),str)
        }
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