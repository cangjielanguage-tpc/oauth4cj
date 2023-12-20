// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuthConstantsB001{
    @TestCase
    func testOAuthConstantsValueCommon01(): Unit {
        @Assert(OAuthConstants.TIMESTAMP,"oauth_timestamp")
        @Assert(OAuthConstants.SIGN_METHOD,"oauth_signature_method")
        @Assert(OAuthConstants.SIGNATURE,"oauth_signature")
        @Assert(OAuthConstants.CONSUMER_SECRET,"oauth_consumer_secret")
        @Assert(OAuthConstants.CONSUMER_KEY,"oauth_consumer_key")
        @Assert(OAuthConstants.CALLBACK,"oauth_callback")
        @Assert(OAuthConstants.VERSION,"oauth_version")
        @Assert(OAuthConstants.NONCE,"oauth_nonce")
        @Assert(OAuthConstants.REALM,"realm")
        @Assert(OAuthConstants.PARAM_PREFIX,"oauth_")
        @Assert(OAuthConstants.TOKEN,"oauth_token")
        @Assert(OAuthConstants.TOKEN_SECRET,"oauth_token_secret")
        @Assert(OAuthConstants.VERIFIER,"oauth_verifier")
        @Assert(OAuthConstants.HEADER_AUTHORIZATION,"Authorization")
        @Assert(OAuthConstants.SCOPE,"scope")
        @Assert(OAuthConstants.BASIC,"Basic")
    }
    @TestCase
    func testOAuthConstantsvalueNoOauthSpecific01(): Unit {
        @Assert(OAuthConstants.USER_AGENT_HEADER_NAME,"User-Agent")
    }
    @TestCase
    func testOAuthConstantsValueOath1001(): Unit {
        @Assert(OAuthConstants.OOB,"oob")
    }
    @TestCase
    func testOAuthConstantsValueCommon02(): Unit {
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