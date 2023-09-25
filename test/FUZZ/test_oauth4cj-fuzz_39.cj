// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_PlaintextSignatureService_getSignature(dp:DataProvider):Int32 {
    var testPlaintextSignatureService=PlaintextSignatureService()
    try{
        testPlaintextSignatureService.getSignature(dp.consumeString(1024),dp.consumeString(1024),dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_PlaintextSignatureService_getSignature).startFuzz()
}