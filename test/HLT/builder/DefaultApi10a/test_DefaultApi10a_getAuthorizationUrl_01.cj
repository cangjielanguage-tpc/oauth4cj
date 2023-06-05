// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetAuthorizationUrl01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        var oauth1RequestToken=OAuth1RequestToken("token","tokenSecret")
        let authorizationUrl=subDefaultApi10a.getAuthorizationUrl(oauth1RequestToken)
        var params=ParameterList()
        params.add("oauth_token",oauth1RequestToken.getToken())
        var exp_re=params.appendTo(subDefaultApi10a.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_re)
    }
}
