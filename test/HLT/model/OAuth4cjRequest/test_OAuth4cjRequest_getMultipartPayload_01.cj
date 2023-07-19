// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func getMultipartPayload(): MultipartPayload
        测试场景:初始化直接获取
    ***/
    @TestCase
    func testOAuth4cjRequestGetMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var muti: MultipartPayload
        try {
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        } catch (e: Exception) {
            println(e)
            oauth4cjRequest01.initMultipartPayload()
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        }
        var boundary=muti.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
    }
}