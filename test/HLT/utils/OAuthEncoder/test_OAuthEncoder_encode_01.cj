// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuthEncoder01{
	
    /***
        包含特殊字符
    ***/
	public var params=Array<String>([" ","*","~"])
    public var res=Array<String>(["%20","%2A","~"])
    public var re=""
    @TestCase
    func testOAuthEncoderEncode01(): Unit {
        for (index in 0..params.size){
            re=OAuthEncoder.encode(params[index])
            @Assert(re,res[index])
        }
    }
}   