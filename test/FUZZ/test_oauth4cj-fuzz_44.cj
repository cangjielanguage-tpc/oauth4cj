// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_AccessTokenRequestParams_setPKCECodeVerifier(dp:DataProvider):Int32 {
    var testAccessTokenRequestParams=AccessTokenRequestParams("code")
    try{
        testAccessTokenRequestParams.setPKCECodeVerifier(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_AccessTokenRequestParams_setPKCECodeVerifier).startFuzz()
}