// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestPreconditions03{
    public var params=Array<String>()
 	//str中仅包含非空白字符， 返回true
    @TestCase
    func testHasText02(): Unit {
        params=Array<String>(["abc","中z~！！@#中12~!@#$%^^&&*30"])//非空白字符串
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
} 