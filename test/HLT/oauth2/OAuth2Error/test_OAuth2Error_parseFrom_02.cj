// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2ErrorB004{
    /***
        public static func parseFrom(errorString: String): OAuth2Error
        测试场景:字符串是否是枚举值对应的errorString-否-抛异常
    ***/
    @TestCase
    func testOAuth2ErrorparseFrom02(): Unit {
        var flag=1
        for (i in strValues){
            flag=1
            try{
                OAuth2Error.parseFrom(i)
            }catch(e:IllegalArgumentException){
                if(e.toString().contains("there is no knowlege about ${i} Error")){
                    flag=0
                }
            }
            @Assert(flag,0)
        }
    }
}