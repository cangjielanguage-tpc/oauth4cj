// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj

from crypto import keys.*
from crypto import digest.*
from std import crypto.digest.*
from std import fs.*

from oauth4cj import oauth4cj.*

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
        }catch(e:OAuth4cjSignatureException){
            println("--------------------------------------------------------")
            println(e.toString())
            if(e.toString().contains("OAuth4cjSignatureException: Error while signing string.Illegal private key file!")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径路径结尾不是.pem
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature02(): Unit {
        let rsss=RSASha1SignatureService("./test_RSASha1SignatureService_01.cj.out")
        var flag=2
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:OAuth4cjSignatureException){
            println(e.toString())
            println("OAuth4cjSignatureException: Error while signing string.Illegal private key file!")
            if(e.toString().contains("OAuth4cjSignatureException: Error while signing string.Illegal private key file!")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径末尾是.pem,但是路径不存在
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature03(): Unit {
        let rsss=RSASha1SignatureService("../../common_Values.pem")
        var flag=3
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:OAuth4cjSignatureException){
            if(e.toString().contains("OAuth4cjSignatureException: Error while signing string.Illegal private key file!")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:秘钥文件路径文件存在，但是文件内容为空
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature04(): Unit {
        var file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        let rsss=RSASha1SignatureService("priKey.pem")
        var flag=4
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:OAuth4cjSignatureException){
            if(e.toString().contains("OAuth4cjSignatureException: Error while signing string."+"X509 parse pem failed: Pem is empty")){
                flag=0
            }
        }
        @Assert(flag,0)
        file01.close()
        File.delete("priKey.pem")
    }
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
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:私钥文件路径结尾是.pem,但文件内容非正常私钥文件
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignature06(): Unit {
        var file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        file01.write("hello cangjie".toArray())
        file01.close()
        file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        let rsss=RSASha1SignatureService("priKey.pem")
        var flag=6
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:OAuth4cjSignatureException){
            if(e.toString().contains("OAuth4cjSignatureException: Error while signing string.X509 parse pem failed: Pem is empty")){
                flag=0
            }
        }
        @Assert(flag,0)
        file01.close()
        File.delete("priKey.pem")
    }
    /***
        public func getSignatureMethod(): String
        测试场景:均返回HMAC-SHA1
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignatureMethod01(): Unit {
        let rsss=RSASha1SignatureService("")
        let re=rsss.getSignatureMethod()
        @Assert(re,"RSA-SHA1")
    }
}

public func getPrivatePem():String{
    //var rsa: RSAPrivateKey = RSA.generateKey(1024)
    //let priKey: Array<UInt8> = rsa.getPrivateKey()
    //var prik: RSAPrivateKey = RSA.setPrivateKey(priKey)
    //prik.writePriKeyToFile("Prikey.pem")
    //return "Prikey.pem"

    let str: String = "-----BEGIN RSA PRIVATE KEY-----" +
                    "MIICXQIBAAKBgQDL4IAf7G5/v+7xdvAzG4TgObhF4Emm/VOmoA7Lj3OGQo0ERT+/" +
                    "AyzYZb/gfu5CYswa3g0PCMetOvSusgcbFAWeguSW3jHxxWjIlyzkVaNuztOHjQbE" +
                    "Bq/Rp7sXa+iwAwygH8LQHVsPQ7ExkXw4BeOly+2mqFryUau7wAxeEQIZkwIDAQAB" +
                    "AoGAStQtcooezHivxKR46OkyzfGhdtQpdEcKit+4TnJqXl7SzzxzdzI9JXfDAyzT" +
                    "Wj5U14+kj14Tm7tFz1C8Vu30WV85fIpB942ooEo1PjBhgNt6yxwP+GqZkqYwly2p" +
                    "dPoB3uAVnBDrEoOSgjrXYkSMxvDyDoVSbshLEMU8uexX1xECQQD4gKpZ/HsIowXq" +
                    "w/4BhvgzIjraiuztExt/uVaQwlhyDhHMI6yMKSTVa25yrCVtkkYKEckH1J0b4w1Q" +
                    "qwmSdudXAkEA0gcqGRLl9TLDhBmg5kKi3xYEGtBA0ZqG8pwZziM6QxSkDz9lOiWO" +
                    "EP0jbDCBUpNdRRKucZ9tYfPsDZ8b/cpmJQJBALjeZ1zoctM7DGTZh7a1JSJNPcFl" +
                    "htrb0yJSzC6HFmtLQjw+8deXqDpJYPJYVMPOBOLq1kZICtU7NaWkiEt4v6MCQQCH" +
                    "xKPdE49dwxQKh/qv/rGEnpnGr4rHNCo6GNjBnZojFOu9A5EvVmmQ5+KHJI/kzmhD" +
                    "p4Dm6FVwNZsJbypMFBOVAkBCwsXB87Kr3kgdq/LvGIC5ROO3+330FSrOS4OQrea+" +
                    "eEOZYMx414a/088WWBirP9iZFK5uConMR/Tpw5zlswtB" +
                    "-----END RSA PRIVATE KEY-----"



    //var rsa: RSAPrivateKey = RSAPrivateKey(1024)
    //let pemEntry: PemEntry = rsa.encodeToPem()
    //let str: String = pemEntry.toString()
    File.writeTo("Prikey.pem", str.toArray(), openOption: OpenOption.CreateOrTruncate(true))
    return "Prikey.pem"
}

public func getExpResult(privateKey:String,baseString:String):String{
    let pemPri: String = String.fromUtf8(File(privateKey, OpenOption.Open(true, false)).readToEnd())
    let rsaPri: RSAPrivateKey = RSAPrivateKey.decodeFromPem(pemPri)
    let sha1Instance: SHA1 = SHA1()
    let md: Array<Byte> = digest(sha1Instance, baseString)
    let signArray: Array<Byte> = rsaPri.sign(sha1Instance, md)
    if (signArray.size == 0) {
        throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
    }
    return Base64Utils.encode(signArray)
}