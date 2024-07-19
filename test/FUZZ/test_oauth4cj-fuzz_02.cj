// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_ServiceBuilderOAuth10a_setApiKey(dp:DataProvider):Int32 {
    var testServiceBuilderOAuth10a=ServiceBuilderOAuth10a("ServiceBuilderOAuth10a")
    try{
        testServiceBuilderOAuth10a.setApiKey(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_ServiceBuilderOAuth10a_setApiKey).startFuzz()
    0
}