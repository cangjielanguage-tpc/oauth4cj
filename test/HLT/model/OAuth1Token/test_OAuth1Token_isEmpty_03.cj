// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1TokenB001{
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