// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: MultipartPayload): OAuth4cjResponse
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.baidu.com"
         let bodyContents=MultipartPayload()
         var flag=1
         try{
             let re_oauth4cjResponse=okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         }catch(e:Exception){
             if(e.toString().contains("OKHttpClient does not support Multipart payload for the moment")){
                 flag=0
             }
         }
         @Assert(flag,0)
    }
}