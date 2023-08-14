// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1RequestTokenB001{
    /***
       测试项：(obj as OAuth1RequestToken)  是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1RequestToken的父类型的实例对象:public class OAuth1RequestToken <: OAuth1Token
    ***/
    @TestCase
    func testEquals01(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1requesttoken01=OAuth1RequestToken("str","str")
        var oauth1requesttoken02=OAuth1RequestToken("str","str","str")
        var oauth1requesttoken03=OAuth1RequestToken("str","str",true,"str")
        @Assert(oauth1requesttoken01.equals(oauth1token01),false)
        @Assert(oauth1requesttoken02.equals(oauth1token01),false)
        @Assert(oauth1requesttoken03.equals(oauth1token01),false)
    }
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
    //构造器传入,不传入
    @TestCase
    func testGetToken01(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (str in strValues) {
            oauth1requesttoken01=OAuth1RequestToken(str,str)
            @Assert(oauth1requesttoken01.getToken(),str)

            oauth1requesttoken02=OAuth1RequestToken(str,str,str)
            @Assert(oauth1requesttoken02.getToken(),str)

            oauth1requesttoken03=OAuth1RequestToken(str,str,true,str)
            @Assert(oauth1requesttoken03.getToken(),str)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testGetTokenSecret01(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (str in strValues) {
            oauth1requesttoken01=OAuth1RequestToken(str,str)
            @Assert(oauth1requesttoken01.getTokenSecret(),str)

            oauth1requesttoken02=OAuth1RequestToken(str,str,str)
            @Assert(oauth1requesttoken02.getTokenSecret(),str)

            oauth1requesttoken03=OAuth1RequestToken(str,str,false,str)
            @Assert(oauth1requesttoken03.getTokenSecret(),str)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testIsOauthCallbackConfirmed01(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("str","str")
        @Assert(oauth1requesttoken01.isOauthCallbackConfirmed(),true)
        var oauth1requesttoken02=OAuth1RequestToken("str","str","str")
        @Assert(oauth1requesttoken02.isOauthCallbackConfirmed(),true)
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (boolValue in boolValues){
            oauth1requesttoken03=OAuth1RequestToken("str","str",boolValue,"str")
            @Assert(oauth1requesttoken03.isOauthCallbackConfirmed(),boolValue)
        }
    }
}
public class A{}