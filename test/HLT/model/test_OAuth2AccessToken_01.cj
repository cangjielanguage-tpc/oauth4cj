// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuth2AccessTokenB001{
    /***
       测试项：(obj as OAuth2AccessToken)  是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的父类型的实例对象:public class OAuth2AccessToken <: Token
    ***/
    @TestCase
    func testEquals01(): Unit {
        var token01=Token()
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.equals(token01),false)

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.equals(token01),false)

        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        @Assert(oauth2accesstoken03.equals(token01),false)

    }
    /***
       测试项：(obj as OAuth2AccessToken)  是  Option<OAuth2AccessToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.equals(otherClass),false)

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.equals(otherClass),false)

        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        @Assert(oauth2accesstoken03.equals(otherClass),false)
    }
    /***
       测试项：(obj as OAuth2AccessToken)  不是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的实例对象，与自身比较
    ***/
    @TestCase
    func testEquals03(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken01),true)

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.equals(oauth2accesstoken02),true)

        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        @Assert(oauth2accesstoken03.equals(oauth2accesstoken03),true)
    }
    /***
       测试项：(oauth2accesstoken02as OAuth2AccessToken)  不是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("345")
        var oauth2accesstoken03=OAuth2AccessToken("123","123")
        var oauth2accesstoken04=OAuth2AccessToken("345","345")
        var oauth2accesstoken05=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        var oauth2accesstoken06=OAuth2AccessToken("345","345",Int32(0),"345","345","345")
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken02),false)
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken03),true)
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken05),false)
        @Assert(oauth2accesstoken04.equals(oauth2accesstoken01),false)
        @Assert(oauth2accesstoken06.equals(oauth2accesstoken01),false)
        @Assert(oauth2accesstoken02.equals(oauth2accesstoken01),false)
    }
    //构造器不同，均能成功获取
    @TestCase
    func testGetAccessToken01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getAccessToken(),str)

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getAccessToken(),str)

            oauth2accesstoken03=OAuth2AccessToken(str,str,Int32(0),str,str,str)
            @Assert(oauth2accesstoken03.getAccessToken(),str)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testGetExpiresIn01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.getExpiresIn(),Int32(0))

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.getExpiresIn(),Int32(0))

        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (int32Value in int32Values){
            oauth2accesstoken03=OAuth2AccessToken("str","str",int32Value,"str","str","str")
            @Assert(oauth2accesstoken03.getExpiresIn(),int32Value)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testGetRefreshToken01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("str","str")
        var oauth2accesstoken03=OAuth2AccessToken("str","str",Int32(0),"str","str","str")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getRefreshToken(),"")

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getRefreshToken(),"")

            oauth2accesstoken03=OAuth2AccessToken(str,str,Int32(0),str,str,str)
            @Assert(oauth2accesstoken03.getRefreshToken(),str)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testGetScope01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getScope(),"")

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getScope(),"")

            oauth2accesstoken03=OAuth2AccessToken(str,str,Int32(0),str,str,str)
            @Assert(oauth2accesstoken03.getScope(),str)
        }
    }
    //构造器传入,不传入
    @TestCase
    func testGetTokenType01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getTokenType(),"")

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getTokenType(),"")

            oauth2accesstoken03=OAuth2AccessToken(str,str,Int32(0),str,str,str)
            @Assert(oauth2accesstoken03.getTokenType(),str)
        }
    }
}
public class A{}