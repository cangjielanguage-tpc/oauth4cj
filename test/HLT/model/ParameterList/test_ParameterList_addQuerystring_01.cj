// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //queryString为空，没有变化
    @TestCase
    func testAddQuerystring01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表

        var queryString=""
        pl01.addQuerystring(queryString)
        pl02.addQuerystring(queryString)
        pl03.addQuerystring(queryString)

        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
    }
}