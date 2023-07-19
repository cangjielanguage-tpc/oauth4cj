// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterB001{
    //字符串角度
    @TestCase
    func testHashCode01(): Unit {
        var p01=Parameter("key01","value01")
        for (i in strValues){
            p01=Parameter(i,i)
            @Assert(p01.hashCode(),i.hashCode()*2)
        }
    }
}