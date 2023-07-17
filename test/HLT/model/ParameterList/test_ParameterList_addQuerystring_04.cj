// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //queryString非空，不含&,不含=
    @TestCase
    func testAddQuerystring04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+1)
        @Assert(pl01.contains(Parameter("abc","")),true)
    }
}