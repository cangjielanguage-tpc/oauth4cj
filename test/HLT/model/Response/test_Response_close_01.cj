// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from std import fs.*

@Test
public class TestResponseB001{
    //无header
    @TestCase
    func testResponseClose01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var file=File("common_Values.cj",OpenOption.CreateOrTruncate(true))
        var sub01=SubResource(file)
        var inputStream01=ByteArrayStream()
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
        response01.close()
        @Assert(file.isClosed(),false)
        try{
            response02.close()
            @Assert(file.isClosed(),true)
        }catch(e:FSException){
            @Assert(file.isClosed(),false)
        }
   }
}

