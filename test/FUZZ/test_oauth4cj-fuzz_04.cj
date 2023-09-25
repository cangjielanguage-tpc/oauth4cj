// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_ServiceBuilderOAuth10a_withScope(dp:DataProvider):Int32 {
    var testServiceBuilderOAuth10a=ServiceBuilderOAuth10a("ServiceBuilderOAuth10a")
    try{
        testServiceBuilderOAuth10a.withScope(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_ServiceBuilderOAuth10a_withScope).startFuzz()
    0
}