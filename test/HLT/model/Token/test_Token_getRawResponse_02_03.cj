// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //子类实例：public class OAuth1RequestToken <: OAuth1Token
    @TestCase
    func testGetRawResponse0203(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (str in strValues) {
            oauth1requesttoken01=OAuth1RequestToken(str,str)
            @Assert(oauth1requesttoken01.getRawResponse(),"")

            oauth1requesttoken02=OAuth1RequestToken(str,str,str)
            @Assert(oauth1requesttoken02.getRawResponse(),str)

            for (boolValue in boolValues){
                oauth1requesttoken03=OAuth1RequestToken(str,str,boolValue,str)
                @Assert(oauth1requesttoken03.getRawResponse(),str)
            }
        }
    }
}