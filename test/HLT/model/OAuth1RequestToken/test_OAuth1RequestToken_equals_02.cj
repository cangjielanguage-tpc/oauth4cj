// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1RequestTokenB001{
    /***
       测试项：(obj as OAuth1RequestToken)  是  Option<OAuth1RequestToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth1requesttoken01=OAuth1RequestToken("str","str")
        var oauth1requesttoken02=OAuth1RequestToken("str","str","str")
        var oauth1requesttoken03=OAuth1RequestToken("str","str",false,"str")
        @Assert(oauth1requesttoken01.equals(otherClass),false)
        @Assert(oauth1requesttoken02.equals(otherClass),false)
        @Assert(oauth1requesttoken03.equals(otherClass),false)
    }
}
public class A{}