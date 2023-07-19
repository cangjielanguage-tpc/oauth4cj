// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,state: ?String, additionalParams: HashMap<String, String>): String
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20GetAuthorizationUrl01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let str_common_option=Option<String>.None
        var map=HashMap<String, String>([("map01","value01")])
        var authorizationUrl=subDefaultApi20.getAuthorizationUrl(str_common,str_common,str_common_option,str_common_option,str_common_option,map)
        var params=ParameterList(map)
        params.add("response_type",str_common)
        params.add("client_id",str_common)
        var exp_authorizationUrl=params.appendTo(subDefaultApi20.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_authorizationUrl)
    }
}
