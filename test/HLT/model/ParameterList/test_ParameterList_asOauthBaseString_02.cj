// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:较少个数
    @TestCase
    func testAsOauthBaseString02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var re_exp=""
		for (i in map02){
		    re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
		}
        re_exp=re_exp.substring(1)
        @Assert(pl03.asOauthBaseString(),OAuthEncoder.encode(re_exp))
    }
}