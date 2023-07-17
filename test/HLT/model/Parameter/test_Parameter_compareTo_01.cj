// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterB001{
    //相等
    @TestCase
    func testCompareTo01(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value01")
        var p03=Parameter("","")
        var p04=Parameter("","")
        @Assert(p01.compareTo(p02),Ordering.EQ)
        @Assert(p03.compareTo(p04),Ordering.EQ)
    }
}