// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径路径结尾不是.pem
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature02(): Unit {
        let rsss=RSASha1SignatureService("../../common_Values.cj")
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"The end of the file name is .pem")){
                flag=0
            }

        }
        @Assert(flag,0)
    }
}