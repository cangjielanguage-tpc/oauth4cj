// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getRevokeTokenEndpoint(): String
        测试场景:不被重写抛异常
    ***/
    @TestCase
    func testDefaultApi20GetRevokeTokenEndpoint01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var flag=1
        try{
            subDefaultApi20.getRevokeTokenEndpoint()
        }catch(e:IllegalArgumentException ){
            if(e.toString().contains("This API doesn't support revoking tokens or we have no info about this")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}
