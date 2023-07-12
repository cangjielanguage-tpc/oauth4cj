// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func setMultipartPayload(multipartPayload: MultipartPayload): Unit
        测试场景：单次设置、多次设置
    ***/
    @TestCase
    func testOAuth4cjRequestSetMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var multipartPayload=MultipartPayload("multipartPayload")
        oauth4cjRequest01.setMultipartPayload(multipartPayload)
        var muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        var boundary=muti.getBoundary()
        @Assert(boundary,"multipartPayload")

        multipartPayload=MultipartPayload()
        oauth4cjRequest01.setMultipartPayload(multipartPayload)

        muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        boundary=muti.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
    }
}