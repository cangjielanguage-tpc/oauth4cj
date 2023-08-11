// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuth1TokenB001{
    //构造器传入,不传入
    @TestCase
    func testGetToken01(): Unit {
        var oauth1token01=OAuth1Token()
        @Assert(oauth1token01.getToken(),"")
        var oauth1token02=OAuth1Token()
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getToken(),str)
        }
    }
    //调用源
    @TestCase
    func testGetTokenSecret01(): Unit {
        var oauth1token01=OAuth1Token()
        @Assert(oauth1token01.getTokenSecret(),"")
        var oauth1token02=OAuth1Token()
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getTokenSecret(),str)
        }
    }
    /***
       测试项：调用源
       测试场景：本类对象调用,返回true
    ***/
    @TestCase
    func testIsEmpty01(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token("","","not empty")
        var oauth1token03=OAuth1Token("","","")
        @Assert(oauth1token01.isEmpty(),true)
        @Assert(oauth1token02.isEmpty(),true)
        @Assert(oauth1token03.isEmpty(),true)
        oauth1token02=OAuth1Token("str","str","not empty")
        oauth1token03=OAuth1Token("str","str","")
        @Assert(oauth1token02.isEmpty(),false)
        @Assert(oauth1token03.isEmpty(),false)
        oauth1token02=OAuth1Token("","str","not empty")
        oauth1token03=OAuth1Token("str","","")
        @Assert(oauth1token02.isEmpty(),false)
        @Assert(oauth1token03.isEmpty(),false)
    }
    /***
       测试项：调用源
       测试场景： 子类OAuth1AccessToken对象调用,返回true
    ***/
    @TestCase
    func testIsEmpty02(): Unit {
        var subOauth1token01=OAuth1AccessToken("","","not empty")
        var subOauth1token02=OAuth1AccessToken("","","")
        var subOauth1token03=OAuth1AccessToken("","")
        @Assert(subOauth1token01.isEmpty(),true)
        @Assert(subOauth1token02.isEmpty(),true)
        @Assert(subOauth1token03.isEmpty(),true)
        subOauth1token01=OAuth1AccessToken("str","str","not empty")
        subOauth1token02=OAuth1AccessToken("str","str","")
        subOauth1token03=OAuth1AccessToken("str","str")
        @Assert(subOauth1token01.isEmpty(),false)
        @Assert(subOauth1token02.isEmpty(),false)
        @Assert(subOauth1token03.isEmpty(),false)
        subOauth1token01=OAuth1AccessToken("","str","not empty")
        subOauth1token02=OAuth1AccessToken("str","","")
        subOauth1token03=OAuth1AccessToken("","str")
        @Assert(subOauth1token01.isEmpty(),false)
        @Assert(subOauth1token02.isEmpty(),false)
        @Assert(subOauth1token03.isEmpty(),false)
    }
    /***
       测试项：调用源
       测试场景： 子类OAuth1RequestToken对象调用,返回true
    ***/
    @TestCase
    func testIsEmpty03(): Unit {
        var subOauth1token01=OAuth1RequestToken("","")
        var subOauth1token02=OAuth1RequestToken("","","123")
        var subOauth1token03=OAuth1RequestToken("","","")
        var subOauth1token04=OAuth1RequestToken("","",true,"123")
        @Assert(subOauth1token01.isEmpty(),true)
        @Assert(subOauth1token02.isEmpty(),true)
        @Assert(subOauth1token03.isEmpty(),true)
        @Assert(subOauth1token04.isEmpty(),true)

        subOauth1token01=OAuth1RequestToken("123","123")
        subOauth1token02=OAuth1RequestToken("123","","123")
        subOauth1token03=OAuth1RequestToken("","123","")
        subOauth1token04=OAuth1RequestToken("123","123",true,"")
        @Assert(subOauth1token01.isEmpty(),false)
        @Assert(subOauth1token02.isEmpty(),false)
        @Assert(subOauth1token03.isEmpty(),false)
        @Assert(subOauth1token04.isEmpty(),false)
    }
}