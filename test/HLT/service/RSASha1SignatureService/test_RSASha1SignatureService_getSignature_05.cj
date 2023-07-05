// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import commons.*
from oauth4cj import services.*
from cryptocj import rsacj.*
from cryptocj import sha1cj.*


@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径文件存在,且内容是私钥
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature05(): Unit {
        var pem_name=getPrivatePem()
        let rsss=RSASha1SignatureService(pem_name)
        var re=rsss.getSignature("baseString","apiSecret","tokenSecret")
        var exp_re=getExpResult(pem_name,"baseString")
        @Assert(re,exp_re)
    }
}
public func getPrivatePem():String{
    var r: RSA = rsaNew()
    rsaGenerateKey(r, Int32(1024))
    pemWriteRsaPri("Prikey.pem",r,false)
    rsaFree(r)
    return "Prikey.pem"
}

public func getExpResult(prikey:String,baseString:String):String{
    let md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
    let data: Array<UInt8> = baseString.toUtf8Array()
    sha1(data, md)
    let rsa: RSA = pemReadRsaPri(prikey, false)
    let (ret, signArray)= rsaSign(RsaTypeId.NID_sha1, md, UInt32(SHA_DIGEST_LENGTH), rsa)
    rsaFree(rsa)
    return Base64Utils.encode(signArray)
}