// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getAccessTokenVerb(): Verb
        测试场景:默认均返回Verb.POST
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenVerb01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getAccessTokenVerb().toString(),Verb.POST.toString())
    }
}