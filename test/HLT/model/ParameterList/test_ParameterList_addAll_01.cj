// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //空列表新增,other为空或者非空
    @TestCase
    func testAddAll01(): Unit {
        var other01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var other02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var other03=ParameterList(map02)//非空表

        var pl01=ParameterList()//空表
        var pl02=ParameterList()//空表
        var pl03=ParameterList()//空表

        var pl04=ParameterList(map01)//空表
        var pl05=ParameterList(map01)//空表
        var pl06=ParameterList(map01)//空表
        pl01.addAll(other01)
        pl02.addAll(other02)
        pl03.addAll(other03)

        pl04.addAll(other01)
        pl05.addAll(other02)
        pl06.addAll(other03)

        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
        @Assert(pl04.size(),0)
        @Assert(pl05.size(),0)
        @Assert(pl06.size(),2)
    }
}