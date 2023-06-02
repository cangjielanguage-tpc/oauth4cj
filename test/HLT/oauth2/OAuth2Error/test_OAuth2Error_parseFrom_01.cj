// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import oauth2.*
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
        var errs=Array<OAuth2Error>([ OAuth2Error.INVALID_REQUEST,
                                        OAuth2Error.UNAUTHORIZED_CLIENT,
                                        OAuth2Error.ACCESS_DENIED,
                                        OAuth2Error.UNSUPPORTED_RESPONSE_TYPE,
                                        OAuth2Error.INVALID_SCOPE,
                                        OAuth2Error.SERVER_ERROR,
                                        OAuth2Error.TEMPORARILY_UNAVAILABLE,
                                        OAuth2Error.INVALID_CLIENT,
                                        OAuth2Error.INVALID_GRANT,
                                        OAuth2Error.UNSUPPORTED_GRANT_TYPE,
                                        OAuth2Error.INVALID_TOKEN,
                                        OAuth2Error.INSUFFICIENT_SCOPE])
        var res=""
        for (i in errStrs){
            res=OAuth2Error.parseFrom(i).getErrorString()
            @Assert(res,i)
        }
    }
}