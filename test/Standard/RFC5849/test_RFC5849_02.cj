// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestRFC5849{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:获取PLAINTEXT签名字符串（这里走不到异常逻辑）,仅字符串角度测试
    ***/
    @TestCase
    func testPlaintextSignatureServiceGetSignature01(): Unit {
        let plSS=PlaintextSignatureService()
        var re=""
        var exp_re=""
        for (str in strValues){
            re=plSS.getSignature(str,str,str)
            exp_re=OAuthEncoder.encode(str) + '&' + OAuthEncoder.encode(str)
            @Assert(re,exp_re)
        }
    }
    /***
        public func getSignatureMethod(): String
        测试场景:均返回PLAINTEXT
    ***/
    @TestCase
    func testPlaintextSignatureServiceGetSignatureMethod01(): Unit {
        let plSS=PlaintextSignatureService()
        let re=plSS.getSignatureMethod()
        @Assert(re,"PLAINTEXT")
    }
}