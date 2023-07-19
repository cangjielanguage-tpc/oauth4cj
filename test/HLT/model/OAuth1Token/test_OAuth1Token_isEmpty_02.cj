// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1TokenB001{
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
}