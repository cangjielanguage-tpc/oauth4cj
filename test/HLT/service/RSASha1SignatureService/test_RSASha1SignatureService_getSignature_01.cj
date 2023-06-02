// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import services.*

@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径为空抛异常
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature01(): Unit {
        let rsss=RSASha1SignatureService("")
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"Please provide the path of RSA private key file!")){
                flag=0
            }

        }
        @Assert(flag,0)
    }
}