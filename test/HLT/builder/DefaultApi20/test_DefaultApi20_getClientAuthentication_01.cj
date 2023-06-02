// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import oauth2.clientauthentication.*

@Test
public class TestDefaultApi20B004{
    /***
        public func getClientAuthentication(): ClientAuthentication
        测试场景:能生成ClientAuthentication即可
    ***/
    @TestCase
    func testDefaultApi20GetClientAuthentication01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let clientAuthentication=subDefaultApi20.getClientAuthentication()
        @Assert(clientAuthentication is HttpBasicAuthenticationScheme,true)
        @Assert(clientAuthentication is ClientAuthentication,true)
    }
}
