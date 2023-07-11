// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1RequestTokenB001{
    /***
       测试项：(obj as OAuth1RequestToken)  不是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1RequestToken的实例对象，与自身比较
    ***/
    @TestCase
    func testEquals03(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("str","str")
        var oauth1requesttoken02=OAuth1RequestToken("str","str","str")
        var oauth1requesttoken03=OAuth1RequestToken("str","str",true,"str")
        @Assert(oauth1requesttoken01.equals(oauth1requesttoken01),true)
        @Assert(oauth1requesttoken02.equals(oauth1requesttoken02),true)
        @Assert(oauth1requesttoken03.equals(oauth1requesttoken03),true)
    }
}