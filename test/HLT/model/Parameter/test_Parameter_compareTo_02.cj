// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterB001{
    //不等
    @TestCase
    func testCompareTo02(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value02")
        var p03=Parameter("key02","value02")
        var p04=Parameter("key02","")

        @Assert(p01.compareTo(p02),Ordering.LT)
        @Assert(p02.compareTo(p01),Ordering.GT)
        @Assert(p02.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p02),Ordering.GT)
        @Assert(p01.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p01),Ordering.GT)

        @Assert(p04.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p04),Ordering.GT)

    }
}