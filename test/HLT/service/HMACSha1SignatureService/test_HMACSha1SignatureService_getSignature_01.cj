// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestHMACSha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:baseString是空字符串
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod01(): Unit {
        let hsss=HMACSha1SignatureService()
        var flag=1
        try{
            hsss.getSignature(" ","not empty","not empty")
        }catch(e:Exception){
            if(e.toString().contains("Base string can't be null or empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}