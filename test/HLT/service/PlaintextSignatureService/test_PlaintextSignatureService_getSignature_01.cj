// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import services.*
from oauth4cj import utils.*
@Test
public class TestPlaintextSignatureServiceB004{
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
}