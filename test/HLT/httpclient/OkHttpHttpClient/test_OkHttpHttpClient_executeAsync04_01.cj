// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: File,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0401(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.baidu.com"
         let bodyContents=File("./test_OkHttpHttpClient_executeAsync04_01.cj.out",OpenOption.Open(true,false))
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         try{
             okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"fail")
         }catch(e:Exception){
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"fail")
         }
    }
}