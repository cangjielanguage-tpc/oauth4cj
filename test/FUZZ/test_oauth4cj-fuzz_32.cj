// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_RequestBodyAuthenticationScheme_addClientAuthentication(dp:DataProvider):Int32 {
    var testRequestBodyAuthenticationScheme =RequestBodyAuthenticationScheme .instance()
    var testOAuth4cjRequest=OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
    try{
        testRequestBodyAuthenticationScheme.addClientAuthentication(testOAuth4cjRequest,dp.consumeString(1024),dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_RequestBodyAuthenticationScheme_addClientAuthentication).startFuzz()
}