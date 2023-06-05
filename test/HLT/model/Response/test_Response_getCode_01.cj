// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from std import fs.*

@Test
public class TestResponseB001{
    //init32Values等价类
    @TestCase
    func testResponseGetCode01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello byte".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
        var response03=Response(Int32(2),"message",HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
        var str="not emnpty"
        for (int32Value in int32Values) {
            response01=Response(int32Value,str,HashMap<String,String>(),str)
            response02=Response(int32Value,str,HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
            response03=Response(int32Value,str,HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
            @Assert(response01.getCode(),int32Value)
            @Assert(response02.getCode(),int32Value)
            @Assert(response03.getCode(),int32Value)
        }
    }
}

