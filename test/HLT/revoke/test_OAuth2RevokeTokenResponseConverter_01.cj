// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth2RevokeTokenResponseConverterB004{
    /***
        public func convert(response: Response): Unit
        测试场景: Response.code==200
    ***/
    @TestCase
    func testOAuth2RevokeTokenResponseConverterConvert01(): Unit {
        var oAuth2RevokeTokenResponseConverter01=OAuth2RevokeTokenResponseConverter()
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),"body")
        var flag=1
        oAuth2RevokeTokenResponseConverter01.convert(response01)
        try{
            oAuth2RevokeTokenResponseConverter01.convert(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
        }
        @Assert(flag,1)
    }
    /***
        public func convert(response: Response): Unit
        测试场景: Response.code!=200
    ***/
    @TestCase
    func testOAuth2RevokeTokenResponseConverterConvert02(): Unit {
        var oAuth2RevokeTokenResponseConverter02=OAuth2RevokeTokenResponseConverter()
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello cangjie".toUtf8Array())
        var response02=oauth4cj.OAuth4cjResponse(Int32(400),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
        var flag=1
        try{
            oAuth2RevokeTokenResponseConverter02.convert(response02)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
        }
        @Assert(flag,0)
    }
}