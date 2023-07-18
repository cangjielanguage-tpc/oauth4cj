// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi10aB004{
    /***
        public func getHeaderExtractor(): HeaderExtractor
        测试场景:能生成HeaderExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetHeaderExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let headerExtractor=subDefaultApi10a.getHeaderExtractor()
        @Assert(headerExtractor is HeaderExtractorImpl,true)
        @Assert(headerExtractor is HeaderExtractor,true)
    }
}
