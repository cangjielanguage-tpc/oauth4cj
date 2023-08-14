// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code不是200-抛异常
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract01(): Unit {
        var deviceAuthorizationJsonExtractor=DeviceAuthorizationJsonExtractor.instance()
        var response=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=0
        try{
            deviceAuthorizationJsonExtractor.extract(response)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=1
        }
        @Assert(flag,1)
    }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract02(): Unit {

        var deviceAuthorizationJsonExtractor=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":5,
"interval":12,
"verification_uri_complete":"verification_uri_complete"}"###
        var response=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=deviceAuthorizationJsonExtractor.extract(response)

        @Assert(re02.getDeviceCode(),"device_code")
        @Assert(re02.getUserCode(),"user_code")
        @Assert(re02.getVerificationUri(),"verification_uri")
        @Assert(re02.getVerificationUriComplete(),"verification_uri_complete")
        @Assert(re02.getExpiresInSeconds(),5)
        @Assert(re02.getIntervalSeconds(),12)

    }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含device_code
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract03(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":"expires_in",
"interval":"interval",
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }

    }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含user_code
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0302(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"verification_uri":"verification_uri",
"expires_in":"expires_in",
"interval":"interval",
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }

    }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含verification_uri
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0303(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"expires_in":"expires_in",
"interval":"interval",
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }

    }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含expires_in
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0304(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"interval":0,
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }
    }
     /***
         public func extract(response: Response): DeviceAuthorization
         测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
         场景：不包含interval
     ***/
     @TestCase
     func testDeviceAuthorizationJsonExtractorExtract0305(): Unit {
         var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
         var body=###"{
 "device_code":"device_code",
 "user_code":"user_code",
 "verification_uri":"verification_uri",
 "expires_in":0,
 "verification_uri_complete":"verification_uri_complete"}"###
         var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
         var re02=deviceAuthorizationJsonExtractor02.extract(response01)

         @Assert(re02.getDeviceCode(),"device_code")
         @Assert(re02.getUserCode(),"user_code")
         @Assert(re02.getVerificationUri(),"verification_uri")
         @Assert(re02.getVerificationUriComplete(),"verification_uri_complete")
         @Assert(re02.getExpiresInSeconds(),0)
         @Assert(re02.getIntervalSeconds(),5)

     }
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含verification_uri_complete,且expires_in,interval不能转化为整数
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0306(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":"expires_in",
"interval":"interval"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=deviceAuthorizationJsonExtractor02.extract(response01)

        @Assert(re02.getDeviceCode(),"device_code")
        @Assert(re02.getUserCode(),"user_code")
        @Assert(re02.getVerificationUri(),"verification_uri")
        @Assert(re02.getVerificationUriComplete(),"")
        @Assert(re02.getExpiresInSeconds(),0)
        @Assert(re02.getIntervalSeconds(),5)

    }
    /***
        public func generateError(response: Response): Unit
        测试场景:正常调用
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorGenerateError01(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=0
        try{
            deviceAuthorizationJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=1
        }
        @Assert(flag,1)
    }
}