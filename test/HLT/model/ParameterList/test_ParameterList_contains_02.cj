// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //不包含,  返回false
    @TestCase
    func testContains02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl01=ParameterList(map02)//非空表
        @Assert(pl01.contains(Parameter("","")),false)
        @Assert(pl01.contains(Parameter("key04","")),false)
        @Assert(pl01.contains(Parameter("key01","value01")),true)
        @Assert(pl01.contains(Parameter("key02","value01")),false)
    }
}