// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

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
            println(e.message)
            if(e.toString().contains("Error while signing string: "+"baseString: "+"The file does not exist")){
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
        let rsss=RSASha1SignatureService("./test_HMACSha1SignatureService_01.cj.out")
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            println(e.message)
            if(e.toString().contains("Illegal RSA Private key")){
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
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"The file does not exist")){
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
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"Illegal RSA Private key")){
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
        file01.write("hello cangjie".toUtf8Array())
        file01.close()
        file01=File("priKey.pem",OpenOption.CreateOrTruncate(true))
        let rsss=RSASha1SignatureService("priKey.pem")
        var flag=1
        try{
            rsss.getSignature("baseString","apiSecret","tokenSecret")
        }catch(e:Exception){
            if(e.toString().contains("Error while signing string: "+"baseString: "+"Illegal RSA Private key")){
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
    // var r: RSA = rsaNew()
    // rsaGenerateKey(r, Int32(1024))
    // pemWriteRsaPri("Prikey.pem",r,false)
    // rsaFree(r)
    var rsa: RSAPrivateKey = RSA.generateKey(1024)
    let priKey: Array<UInt8> = rsa.getPrivateKey()
    var prik: RSAPrivateKey = RSA.setPrivateKey(priKey)
    prik.writePriKeyToFile("Prikey.pem")
    return "Prikey.pem"
}

public func getExpResult(prikey:String,baseString:String):String{
    // let md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
    // let data: Array<UInt8> = baseString.toUtf8Array()
    // sha1(data, md)
    // let rsa: RSA = pemReadRsaPri(prikey, false)
    // let (ret, signArray)= rsaSign(RsaTypeId.NID_sha1, md, UInt32(SHA_DIGEST_LENGTH), rsa)
    // if (ret == 0) {
    //     throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
    // }
    // rsaFree(rsa)

    let data: Array<UInt8> = baseString.toUtf8Array()
    // sha1(data, md)
    var digest: Array<UInt8> = Digest.digest(DigestType.sha1, data)
    // let rsa: RSA = pemReadRsaPri(privateKey, false)
    let rsa: RSAPrivateKey = RSA.readPriKeyfromFile(prikey)
    // let (ret, signArray): (Int32, Array<UInt8>) = rsaSign(NID_sha1, md, UInt32(SHA_DIGEST_LENGTH), rsa)
    let signArray: Array<UInt8> = RSA.sign(DigestType.sha1, digest, rsa)
    if (signArray.size == 0) {
        throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
    }
    return Base64Utils.encode(signArray)
}
