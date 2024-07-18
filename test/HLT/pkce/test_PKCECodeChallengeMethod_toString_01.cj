// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj

import crypto.keys.*
import crypto.digest.*
import std.crypto.digest.*

public import oauth4cj.*

public import httpclient4cj.HttpClient as Httpclient4cjHttpClient
public import httpclient4cj.Request as Httpclient4cjRequest
public import httpclient4cj.Response as Httpclient4cjResponse
public import httpclient4cj.RequestBuilder as Httpclient4cjRequestBuilder
public import httpclient4cj.ResponseBuilder as Httpclient4cjResponseBuilder

public var strEmpty=""
public  var strBlank=" "
public  var strMulti="""
    Hello,
    Oauth4cj"""

public  var strOriginMulti=###"
    Hello,
    Oauth4cj"###
public var strCommon="hello Cangjie"
/*****    返回固定长度字符串 ****/
public func getStringByLength(length:Int64):String{
    var str02=""
    var i=0
    while(i<length){
        str02+=i.toString()
        i=str02.size
    }
    return str02
}

public var strValues=Array<String>([strEmpty,getStringByLength(1000),strMulti,strOriginMulti,strBlank,strCommon])


@Test
public class TestPKCECodeChallengeMethodB002{
    @TestCase
    func testPKCECodeChallengeMethodToString01(): Unit {
        @Assert(PKCECodeChallengeMethod.S256.toString(),"S256")
        @Assert(PKCECodeChallengeMethod.PLAIN.toString(),"PLAIN")
    }
    /***
        调用源PKCECodeChallengeMethod.S256
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge01(): Unit {
        var codeChallengeMethod_S256=PKCECodeChallengeMethod.S256
        var re=""
        var exp_re=""
        //var temp= Array<UInt8>(32,item:0)
        strValues=Array<String>([strEmpty,getStringByLength(1000),strBlank,strCommon])
        for (str in strValues){
            re=codeChallengeMethod_S256.transform2CodeChallenge(str)
            //sha256(str.toArray(),temp)
            //exp_re=Base64Utils.encodeUrlWithoutPadding(temp)

            let SHA256Instance: SHA256 = SHA256()
            let md: Array<Byte> = digest(SHA256Instance, str)
            exp_re=Base64Utils.encodeUrlWithoutPadding(md)

            @Assert(re,exp_re)
        }
    }
    /***
        调用源PKCECodeChallengeMethod.PLAIN
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge02(): Unit {
        var codeChallengeMethod_PLAIN=PKCECodeChallengeMethod.PLAIN
        var re=""
        for (str in strValues){
            re=codeChallengeMethod_PLAIN.transform2CodeChallenge(str)
            @Assert(re,str)
        }
    }
}
