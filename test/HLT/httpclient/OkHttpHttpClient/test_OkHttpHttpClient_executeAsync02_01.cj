// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: MultipartPayload,
         callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.baidu.com"
         let bodyContents=MultipartPayload()
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         var flag=1
         try{
             okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
         }catch(e:Exception){
             if(e.toString().contains("OKHttpClient does not support Multipart payload for the moment")){
                 flag=0
             }
         }
         @Assert(flag,0)
    }
}