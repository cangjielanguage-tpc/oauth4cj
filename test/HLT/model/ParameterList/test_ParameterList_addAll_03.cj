// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //多次新增达到1000次
    @TestCase
    func testAddAll03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var other03=ParameterList(map02)//非空表
        var pl03=ParameterList(map02)
        var baseSize=pl03.size()
        var i=0
		while(i<1000){
            pl03.addAll(other03)
            i+=1
		}
        @Assert(pl03.size(),baseSize+other03.size()*1000)
    }
}