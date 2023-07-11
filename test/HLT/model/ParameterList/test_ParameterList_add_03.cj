// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestParameterListV003{
    //多次连续新增(键值对存在/不存在)
    @TestCase
    func testAdd03(): Unit {
        var pl01=ParameterList()
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)
        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
        pl01.add("key01","value01")
        pl01.add("key02","value02")
        pl01.add("key03","value03")
        pl02.add("key01","value01")
        pl02.add("key02","value02")
        pl02.add("key03","value03")
        pl03.add("key02","value02")
        pl03.add("key03","value03")
        @Assert(pl01.size(),3)
        @Assert(pl02.size(),3)
        @Assert(pl03.size(),4)
    }
}