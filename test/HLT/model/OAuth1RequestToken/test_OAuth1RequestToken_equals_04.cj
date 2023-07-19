// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1RequestTokenB001{
    /***
       测试项：(oauth1requesttoken02as OAuth1RequestToken)  不是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1RequestToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("str","str")
        var oauth1requesttoken02=OAuth1RequestToken("str","str","str")
        var oauth1requesttoken03=OAuth1RequestToken("str","str",true,"str")
        @Assert(oauth1requesttoken02.equals(oauth1requesttoken01),true)
        @Assert(oauth1requesttoken01.equals(oauth1requesttoken02),true)
        @Assert(oauth1requesttoken03.equals(oauth1requesttoken02),true)
        @Assert(oauth1requesttoken02.equals(oauth1requesttoken03),true)
        @Assert(oauth1requesttoken01.equals(oauth1requesttoken03),true)
        @Assert(oauth1requesttoken03.equals(oauth1requesttoken01),true)
    }
}
