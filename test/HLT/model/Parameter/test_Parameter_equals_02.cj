// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestParameterB001{
    //不等
    @TestCase
    func testEquals02(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value02")
        var p03=Parameter("key02","value02")
        var p04=Parameter("key02","")
        var p05=Parameter("","value02")
        var p06=Parameter("","")
        @Assert(p01==p02,false)
        @Assert(p03==p02,false)
        @Assert(p03==p01,false)
        @Assert(p04==p06,false)
        @Assert(p05==p06,false)
        @Assert(p04==p06,false)
    }
}