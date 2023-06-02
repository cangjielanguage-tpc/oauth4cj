// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuthConstantsB001{
    @TestCase
    func testOAuthConstantsValueCommon01(): Unit {
        @Assert(OAuthConstants.ACCESS_TOKEN,"access_token")
        @Assert(OAuthConstants.CLIENT_ID,"client_id")
        @Assert(OAuthConstants.CLIENT_SECRET,"client_secret")
        @Assert(OAuthConstants.REDIRECT_URI,"redirect_uri")
        @Assert(OAuthConstants.CODE,"code")
        @Assert(OAuthConstants.REFRESH_TOKEN,"refresh_token")
        @Assert(OAuthConstants.GRANT_TYPE,"grant_type")
        @Assert(OAuthConstants.AUTHORIZATION_CODE,"authorization_code")
        @Assert(OAuthConstants.CLIENT_CREDENTIALS,"client_credentials")
        @Assert(OAuthConstants.STATE,"state")
        @Assert(OAuthConstants.USERNAME,"username")
        @Assert(OAuthConstants.PASSWORD,"password")
        @Assert(OAuthConstants.RESPONSE_TYPE,"response_type")
        @Assert(OAuthConstants.RESPONSE_TYPE_CODE,"code")
    }
}