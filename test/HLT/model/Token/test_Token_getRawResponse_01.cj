// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //本类实例
    @TestCase
    func testGetRawResponse01(): Unit {
        var token01=Token()
        var token02=Token()
        @Assert(token01.getRawResponse(),"")
        for (str in strValues) {
            token02=Token(str)
            @Assert(token02.getRawResponse(),str)
        }
    }
}