// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2ErrorB004{
    /***
        public static func parseFrom(errorString: String): OAuth2Error
        测试场景:字符串是否是枚举值对应的errorString-是-返回字枚举值对象
    ***/
    @TestCase
    func testOAuth2ErrorparseFrom01(): Unit {
        var errStrs=Array<String>(["invalid_request","unauthorized_client","access_denied","unsupported_response_type",
                                   "invalid_scope","server_error","temporarily_unavailable","invalid_client",
                                   "invalid_grant","unsupported_grant_type","invalid_token","insufficient_scope",
                                   "unsupported_token_type","authorization_pending","slow_down","expired_token"])
        var res=""
        for (i in errStrs){
            res=OAuth2Error.parseFrom(i).getErrorString()
            @Assert(res,i)
        }
    }
}