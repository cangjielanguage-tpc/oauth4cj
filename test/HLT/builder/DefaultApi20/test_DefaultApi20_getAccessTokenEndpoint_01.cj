// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi20B004{
    /***
        public open func getAccessTokenEndpoint(): String
        测试场景:根据实现类重写返回结果
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenEndpoint01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getAccessTokenEndpoint(),"accessTokenEndpoint_DefaultApi20")
    }
}