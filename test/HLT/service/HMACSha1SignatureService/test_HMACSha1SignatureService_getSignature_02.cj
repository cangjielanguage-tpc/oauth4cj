// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*
from oauth4cj import services.*
from cryptocj import hmaccj.*

@Test
public class TestHMACSha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:baseString是非空字符串
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod01(): Unit {
        let hsss=HMACSha1SignatureService()
        var re=""
        var exp_re=""
        var keyStr=""
        for (str in strValues){
            keyStr=OAuthEncoder.encode(str) + '&' + OAuthEncoder.encode(str)
            re=hsss.getSignature("baseString",str,str)
            exp_re=getHAMCSHA1String("baseString",keyStr)
            @Assert(re,exp_re)
        }

    }
}
public func getHAMCSHA1String(toSign: String,keyString: String):String{
   let algorithm: AlgorithmType = AlgorithmType.Sha1
   let key=keyString.toUtf8Array()
   let data=toSign.toUtf8Array()
   var md: Array<UInt8> = Array<UInt8>(20, item: 0)
   hmac(algorithm, key, data, md)
   return Base64Utils.encode(md).replace("\r\n","")
}