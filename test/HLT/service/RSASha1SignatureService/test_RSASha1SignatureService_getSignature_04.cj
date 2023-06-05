// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import services.*
from std import fs.*

@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径文件存在，但是文件内容为空
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature04(): Unit {
        var file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
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