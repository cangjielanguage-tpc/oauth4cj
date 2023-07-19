// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB002{
    //非空列表,经过改变后，也随之变化
    @TestCase
    func testGetParams02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        @Assert(pl03.size(),2)
        pl03.add("key03","value03")
        @Assert(pl03.size(),3)
        @Assert(pl03.getParams().size,3)
    }
}