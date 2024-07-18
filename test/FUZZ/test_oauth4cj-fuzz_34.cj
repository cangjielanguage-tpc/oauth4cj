// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_PKCE_setCodeVerifier(dp:DataProvider):Int32 {
    var testPKCE=PKCE()
    try{
        testPKCE.setCodeVerifier(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_PKCE_setCodeVerifier).startFuzz()
}