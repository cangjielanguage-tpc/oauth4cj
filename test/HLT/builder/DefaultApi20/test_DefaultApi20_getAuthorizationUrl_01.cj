// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*
from std import collection.*

@Test
public class TestDefaultApi20B004{
    /***
        public func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,state: ?String, additionalParams: HashMap<String, String>): String
        测试场景:callback ,scope,state均不是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20GetAuthorizationUrl01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let str_common_option=Option<String>.Some(str_common)
        var map=HashMap<String, String>([("map01","value01")])
        var authorizationUrl=subDefaultApi20.getAuthorizationUrl(str_common,str_common,str_common_option,str_common_option,str_common_option,map)
        var params=ParameterList(map)
        params.add("response_type",str_common)
        params.add("client_id",str_common)
        params.add("redirect_uri",str_common_option.getOrThrow())
        params.add("scope",str_common_option.getOrThrow())
        params.add("state",str_common_option.getOrThrow())
        var exp_authorizationUrl=params.appendTo(subDefaultApi20.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_authorizationUrl)
    }
}
