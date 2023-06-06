// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB005{
    /***
        public func getMultipartPayload(): MultipartPayload
        测试场景:初始化直接获取
    ***/
    @TestCase
    func testOAuth4cjRequestGetMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var muti: MultipartPayload
        try {
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        } catch (e: Exception) {
            println(e)
            oauth4cjRequest01.initMultipartPayload()
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        }
        var boundary=muti.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
    }
}