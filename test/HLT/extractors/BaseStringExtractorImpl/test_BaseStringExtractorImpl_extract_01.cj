// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestBaseStringExtractorImplB004{
    /***
        public func extract(request: OAuth4cjRequest): String
        测试场景:无oauth参数-抛异常
    ***/
    @TestCase
    func testBaseStringExtractorImplExtract01(): Unit {
        var baseStringExtractorImpl01=BaseStringExtractorImpl()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
        var flag=0
        try{
            baseStringExtractorImpl01.extract(oauth4cjRequest)
        }catch(e:OAuth4cjParametersMissingException){
            if(e.toString().contains(oauth4cjRequest.toString())){
                 flag=1
            }
        }
        @Assert(flag,1)
    }
}