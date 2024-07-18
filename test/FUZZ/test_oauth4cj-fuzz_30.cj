// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_BearerSignatureURIQueryParameter_signRequest(dp:DataProvider):Int32 {
    var testBearerSignatureURIQueryParameter=BearerSignatureURIQueryParameter.instance()
    var testOAuth4cjRequest=OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
    try{
        testBearerSignatureURIQueryParameter.signRequest(dp.consumeString(300),testOAuth4cjRequest)//服务器错误信息一般不会很长
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_BearerSignatureURIQueryParameter_signRequest).startFuzz()
}