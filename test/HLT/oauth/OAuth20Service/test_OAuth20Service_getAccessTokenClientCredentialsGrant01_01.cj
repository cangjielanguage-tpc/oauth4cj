// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAccessTokenClientCredentialsGrant(): OAuth2AccessToken
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessTokenClientCredentialsGrant0101(): Unit {
        //将这些替换为在【授权服务器-华为】中生成的 client_id 和 client_secret
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"

        //替换成自己需要的权限范围
        //此授权范围是在【授权服务器-华为】申请的授权，多个权限用空格隔开
        let SCOP: String = "openid profile email"

        //替换成自己需要请求的，受保护的资源的链接
        //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
        let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                //设置回调url{redirect_uri}，用于后面获取授权码code
                setCallback("http://www.example.com/oauth_callback/").
                build(HuaweiApi.instance())

        //=== 华为的OAuth工作流 ===

        //1. 调用客户端模式，获取访问令牌！
        //RFC 6749 OAuth 2.0授权框架，客户端凭据授权授予
        let accessToken: OAuth2AccessToken = service.getAccessTokenClientCredentialsGrant()

        //2. 请求一个受保护的资源！
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)

        //2.1 请求签名
        service.signRequest(accessToken, request)

        //2.2 调用同步请求执行
        let response = service.execute(request)
         @Assert(response.getCode(),200)
    }
}