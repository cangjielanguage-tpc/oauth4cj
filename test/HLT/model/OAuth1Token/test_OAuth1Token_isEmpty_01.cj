// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1TokenB001{
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
}