// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1AccessTokenB001{
    /***
       测试项：(obj as OAuth1AccessToken)  是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1AccessToken的父类型的实例对象:public class OAuth1RequestToken <: OAuth1Token
    ***/
    @TestCase
    func testEquals01(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")

        oauth1accesstoken01=OAuth1AccessToken("str","str")
        @Assert(oauth1accesstoken01.equals(oauth1token01),false)

        oauth1accesstoken02=OAuth1AccessToken("str","str","str")
        @Assert(oauth1accesstoken02.equals(oauth1token01),false)
    }     /***
       测试项：(obj as OAuth1AccessToken)  是  Option<OAuth1AccessToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")

        oauth1accesstoken01=OAuth1AccessToken("str","str")
        @Assert(oauth1accesstoken01.equals(otherClass),false)

        oauth1accesstoken02=OAuth1AccessToken("str","str","str")
        @Assert(oauth1accesstoken02.equals(otherClass),false)
    }
    /***
       测试项：(obj as OAuth1AccessToken)  不是  Option<OAuth1AccessToken>.None
       测试场景： object是OAuth1AccessToken的实例对象，与自身比较
    ***/
    @TestCase
    func testEquals03(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        @Assert(oauth1accesstoken01.equals(oauth1accesstoken01),true)

        var oauth1accesstoken02=OAuth1AccessToken("123","123","123")
        @Assert(oauth1accesstoken02.equals(oauth1accesstoken02),true)
    }
    /***
       测试项：(obj as OAuth1AccessToken)  不是  Option<OAuth1AccessToken>.None
       测试场景： object是OAuth1AccessToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")
        var oauth1accesstoken03=OAuth1AccessToken("123","123","123")

        @Assert(oauth1accesstoken01.equals(oauth1accesstoken02),true)
        @Assert(oauth1accesstoken02.equals(oauth1accesstoken03),true)
        @Assert(oauth1accesstoken01.equals(oauth1accesstoken03),true)
    }
    //调用源
    @TestCase
    func testGetToken01(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123","123")
        for (str in strValues) {
            oauth1accesstoken01=OAuth1AccessToken(str,str)
            @Assert(oauth1accesstoken01.getToken(),str)

            oauth1accesstoken02=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken02.getToken(),str)
        }
    }
    //调用源
    @TestCase
    func testGetTokenSecret01(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")
        for (str in strValues) {
            oauth1accesstoken01=OAuth1AccessToken(str,str)
            @Assert(oauth1accesstoken01.getTokenSecret(),str)

            oauth1accesstoken02=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken02.getTokenSecret(),str)
        }
    }
}
public class A{}