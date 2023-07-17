// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:私钥文件路径结尾是.pem,但文件内容非正常私钥文件
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature06(): Unit {
        var file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        file01.write("hello cangjie".toUtf8Array())
        file01.close()
        file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        let rsss=RSASha1SignatureService("priKey.pem")
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"Please check the key")){
                flag=0
            }
        }
        @Assert(flag,0)
        file01.close()
        File.delete("priKey.pem")
    }
}