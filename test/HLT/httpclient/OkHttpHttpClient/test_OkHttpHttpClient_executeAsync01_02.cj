// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: Array<UInt8>,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送错误请求====异步执行,没有结果待验证
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0102(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents=Array<UInt8>([1,2,3,4,5])
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         let response_any=okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter).get()
         var reflag=1
         try{
             let response= (response_any as oauth4cj.model.Response).getOrThrow()
         }catch(e:NoneValueException){
             reflag=0
         }
         @Assert(reflag,0)
         @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"fail")
         @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
    }
}