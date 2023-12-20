// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_PKCECodeChallengeMethod_transform2CodeChallenge(dp:DataProvider):Int32 {
    var testtransform2CodeChallenge=PKCECodeChallengeMethod.S256
    try{
        testtransform2CodeChallenge.transform2CodeChallenge(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_PKCECodeChallengeMethod_transform2CodeChallenge).startFuzz()
}