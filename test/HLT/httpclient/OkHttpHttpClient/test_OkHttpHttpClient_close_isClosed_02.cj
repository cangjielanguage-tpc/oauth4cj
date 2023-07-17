// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func close(): Unit
        public func isClosed(): Bool
        测试场景: 重复关闭
    ***/
    //public init()
    @TestCase
    func testOkHttpHttpClientClose0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         okhttpHttpClient.close()
         okhttpHttpClient.close()
         @Assert(okhttpHttpClient.isClosed(),true)
    }
}