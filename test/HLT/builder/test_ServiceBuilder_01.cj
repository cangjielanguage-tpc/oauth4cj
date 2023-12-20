// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func build(api: DefaultApi10a): OAuth10aService
        测试场景:验证返回确认是OAuth10aService
    ***/
    @TestCase
    func testServiceBuilderBuild0101(): Unit {
        var serviceBuilder=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        let oauth10aService=serviceBuilder.build(subDefaultApi10a)
        @Assert(oauth10aService.getVersion(),"1.0")
        @Assert(oauth10aService is OAuth10aService,true)
    }
    /***
        public func build(api: DefaultApi20): OAuth20Service
        测试场景:验证返回确认是OAuth20Service
    ***/
    @TestCase
    func testServiceBuilderBuild0201(): Unit {
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        let oauth20Service=serviceBuilder.build(subDefaultApi20)
        @Assert(oauth20Service.getVersion(),"2.0")
        @Assert(oauth20Service is OAuth20Service,true)
    }
    /***
        public init(apiKey: String)
        测试场景:字符串是否是空白字符串-是
    ***/
    @TestCase
    func testServiceBuilderInit01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01=ServiceBuilderOAuth10a("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01=ServiceBuilderOAuth10a("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02=ServiceBuilderOAuth20("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        flag02=1
        try{
            serviceBuilder02=ServiceBuilderOAuth20("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
    /***
        public init(apiKey: String)
        测试场景:字符串是否是空白字符串-否
    ***/
    @TestCase
    func testServiceBuilderInit02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        var oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        serviceBuilder01=ServiceBuilderOAuth10a("str")
        oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService.getApiKey(),"str")
        @Assert(oauth10aService is OAuth10aService,true)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        var oauth20Service=serviceBuilder02.build(subDefaultApi20)
        serviceBuilder02=ServiceBuilderOAuth20("str")
        oauth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oauth10aService.getApiKey(),"str")
        @Assert(oauth20Service is OAuth20Service,true)
    }
    /***
        public func setApiKey(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuilderSetApiKey01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01.setApiKey("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setApiKey("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setApiKey("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        flag02=1
        try{
            serviceBuilder02.setApiKey("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
    /***
        public func setApiKey(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuilderSetApiKey02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setApiKey("str")
        let oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService.getApiKey(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setApiKey("str")
        let oauth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oauth20Service.getApiKey(),"str")
    }
    /***
        public func setApiSecret(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01.setApiSecret("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api secret")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setApiSecret("    ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api secret")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setApiSecret("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api secret")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        flag02=1
        try{
            serviceBuilder02.setApiSecret("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid Api secret")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
    /***
        public func setApiSecret(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetApiSecret02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setApiSecret("str")
        let oAuth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oAuth10aService.getApiSecret(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setApiSecret("str")
        let oauth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oauth20Service.getApiSecret(),"str")
    }
    /***
        public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder
        测试场景:验证字符串是否为空-默认调用
    ***/
    @TestCase
    func testServiceBuildersetApiSecretIsEmptyStringUnsafe01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        serviceBuilder01.setApiSecretIsEmptyStringUnsafe()

        var subDefaultApi10a=SubDefaultApi10a()
        let oAuth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oAuth10aService.getApiSecret(),"")


        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        serviceBuilder02.setApiSecretIsEmptyStringUnsafe()
        var subDefaultApi20=SubDefaultApi20()
        let oAuth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service.getApiSecret(),"")
    }
    /***
        public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder
        测试场景:验证字符串是否为空-设置后调用
    ***/
    @TestCase
    func testServiceBuildersetApiSecretIsEmptyStringUnsafe02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()

        let apiSecret="hello cangjie"

        serviceBuilder01.setApiSecret(apiSecret)
        let oauth10aService01=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService01.getApiSecret(),apiSecret)

        serviceBuilder01.setApiSecretIsEmptyStringUnsafe()
        let oauth10aService02=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService02.getApiSecret(),"")


        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setApiSecret(apiSecret)
        let oAuth20Service01=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service01.getApiSecret(),apiSecret)

        serviceBuilder02.setApiSecretIsEmptyStringUnsafe()
        let oAuth20Service02=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service02.getApiSecret(),"")
    }
    /***
        public func setCallback(callback: String): ServiceBuilder
        测试场景:无设置逻辑,设置成功即可
    ***/
    @TestCase
    func testServiceBuilderSetCallback01(): Unit {
        var serviceBuilder01 = ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setCallback("str")
        let oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService.getCallback(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setCallback("str")
        let oAuth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service.getCallback(),"str")
    }
    /***
        public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0101(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var flag=1
        try{
            serviceBuilder01.setDefaultScope("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setDefaultScope(" ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0102(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var re=serviceBuilder01.setDefaultScope("str")
        @Assert(re is ServiceBuilderOAuth20,true)
    }
    /***
        public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0201(): Unit {
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var scopeBuilder=ScopeBuilder()
        var flag=1
        try{
            serviceBuilder.setDefaultScope(scopeBuilder)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException: Cannot get String from a empty ScopeBuilder")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0202(): Unit {
        var scopeBuilder=ScopeBuilder("abc")
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var re=serviceBuilder.setDefaultScope(scopeBuilder)
        @Assert(re is ServiceBuilderOAuth20,true)
    }
    /***
        public func setHttpClient(httpClient: ?HttpClient): ServiceBuilder
        测试场景:验证字符串是否Option<OAuth4cjHttpClient>.None
    ***/
    @TestCase
    func testServiceBuildersetHttpClient01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var httpclient=Option<OAuth4cjHttpClient>.None
        var flag=0
        try{
            serviceBuilder01.setHttpClient(httpclient)
        }catch(e:Exception){
            flag=1
        }
        @Assert(flag,0)
        flag=0
        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var httpclient02=Option<OAuth4cjHttpClient>.None
        try{
            serviceBuilder02.setHttpClient(httpclient02)
        }catch(e:Exception){
            flag=1
        }
        @Assert(flag,0)
    }
    /***
        public func setHttpClientConfig(httpClientConfig: ?HttpClientConfig): ServiceBuilder
        测试场景:验证字符串是Option<HttpClientConfig>.None
    ***/
    @TestCase
    func testServiceBuildersetHttpClientConfig01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var config=Option<HttpClientConfig>.None
        var flag=1
        try{
            serviceBuilder01.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("httpClientConfig can't be null")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("httpClientConfig can't be null")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
    /***
        public func setHttpClientConfig(httpClientConfig: ?HttpClientConfig): ServiceBuilder
        测试场景:验证字符串是Option<HttpClientConfig>.Some
    ***/
    @TestCase
    func testServiceBuildersetHttpClientConfig02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var config=Option<HttpClientConfig>.Some(SubHttpClientConfig.defaultConfig())
        var flag=1
        try{
            serviceBuilder01.setHttpClientConfig(config)
        }catch(e:Exception){
            flag=0
        }
        @Assert(flag,1)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setHttpClientConfig(config)
        }catch(e:Exception){
            flag02=0
        }
        @Assert(flag02,1)
    }
    /***
        public func setResponseType(responseType: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetResponseType01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var flag=1
        try{
            serviceBuilder01.setResponseType("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth responseType")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setResponseType("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth responseType")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func setResponseType(responseType: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetResponseType02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        var str="andfsopfks"
        serviceBuilder01.setResponseType(str)
        let OAuth20Service=serviceBuilder01.build(subDefaultApi20)
        @Assert(OAuth20Service.getResponseType(),str)
    }
    /***
        public func setUserAgent(userAgent: String): ServiceBuilder
        测试场景:字符串角度,只能验证正常调用
    ***/
    @TestCase
    func testServiceBuilderSetUserAgent01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=0
        try{
            serviceBuilder01.setUserAgent("user-agent")
        }catch(e:Exception){
            flag=1
        }
        @Assert(flag,0)
        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        flag=0
        try{
            serviceBuilder02.setUserAgent("")
        }catch(e:Exception){
            flag=1
        }
        @Assert(flag,0)
    }
    /***
        public func withScope(scope: String): ServiceBuilderOAuth10a
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuilderwithScope01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01.withScope("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.withScope("        ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func withScope(scope: String): ServiceBuilderOAuth10a
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuilderwithScope02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var re=serviceBuilder01.withScope("str")
        @Assert(re is ServiceBuilderOAuth10a,true)
    }
    /***
        public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderOAuth10a
        测试场景:生成即可
    ***/
    @TestCase
    func testServiceBuildersetHttpClientProvider01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var re=serviceBuilder01.setHttpClientProvider(Option<HttpClientProvider>.None)
        @Assert(re is ServiceBuilderOAuth10a,true)
    }
	/***
	    public func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilderOAuth10a
        测试场景:生成即可
    ***/
    @TestCase
    func testServiceBuildersetDebugStream01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var re=serviceBuilder01.setDebugStream(Option<OutputStream>.None)
        @Assert(re is ServiceBuilderOAuth10a,true)
    }	
}
public class SubHttpClientConfig <:HttpClientConfig{
    public func createDefaultConfig():SubHttpClientConfig{
        return defaultConfig()
    }
    public static func defaultConfig():SubHttpClientConfig {
        return SubHttpClientConfig()
    }
}