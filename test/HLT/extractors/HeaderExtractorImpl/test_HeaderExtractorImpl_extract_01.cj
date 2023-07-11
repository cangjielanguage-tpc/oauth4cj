// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestHeaderExtractorImplB004{
    /***
        public func extract(request: OAuth4cjRequest): String
        测试场景:oauth参数为空,realm为空
    ***/
    @TestCase
    func testHeaderExtractorImplExtract01(): Unit {
        var headerExtractorImpl01=HeaderExtractorImpl()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var flag=0
        try{
            headerExtractorImpl01.extract(oauth4cjRequest)
        }catch(e:OAuth4cjParametersMissingException){
            if(e.toString().contains("Could not find oauth parameters in request: ${oauth4cjRequest}. "+ "OAuth parameters must be specified with the addOAuthParameter() method")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
}