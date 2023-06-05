// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import services.*

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