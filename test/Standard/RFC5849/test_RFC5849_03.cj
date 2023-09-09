// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestRFC5849{
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:baseString是空字符串
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod01(): Unit {
        let hsss=HMACSha1SignatureService()
        var flag=1
        try{
            hsss.getSignature(" ","not empty","not empty")
        }catch(e:Exception){
            if(e.toString().contains("Base string can't be null or empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
        测试场景:baseString是非空字符串
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod02(): Unit {
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
    /***
        public func getSignatureMethod(): String
        测试场景:均返回HMAC-SHA1
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod03(): Unit {
        let hsss=HMACSha1SignatureService()
        let re=hsss.getSignatureMethod()
        @Assert(re,"HMAC-SHA1")
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