// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_HMACSha1SignatureService_getSignature(dp:DataProvider):Int32 {
    var testHMACSha1SignatureService=HMACSha1SignatureService()
    try{
        testHMACSha1SignatureService.getSignature(dp.consumeString(1024),dp.consumeString(1024),dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_HMACSha1SignatureService_getSignature).startFuzz()
}