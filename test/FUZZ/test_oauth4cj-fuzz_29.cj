// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_BearerSignatureAuthorizationRequestHeaderField_signRequest(dp:DataProvider):Int32 {
    var testBearerSignatureAuthorizationRequestHeaderField=BearerSignatureAuthorizationRequestHeaderField.instance()
    var testOAuth4cjRequest=OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
    try{
        testBearerSignatureAuthorizationRequestHeaderField.signRequest(dp.consumeString(300),testOAuth4cjRequest)//服务器错误信息一般不会很长
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_BearerSignatureAuthorizationRequestHeaderField_signRequest).startFuzz()
}