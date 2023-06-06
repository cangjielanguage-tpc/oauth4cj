// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*

@Test
public class TestOAuth4cjRequestB005{
    /***
        public func initMultipartPayload(boundary: String): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0201(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="11111111111111111"
        oauth4cjRequest.initMultipartPayload(str)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary,str)
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
}