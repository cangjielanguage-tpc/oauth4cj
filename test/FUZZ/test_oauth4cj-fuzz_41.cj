// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_RSASha1SignatureService_getSignature(dp:DataProvider):Int32 {
    var testRSASha1SignatureService=RSASha1SignatureService("private Key")
    try{
        testRSASha1SignatureService.getSignature(dp.consumeString(1024),dp.consumeString(1024),dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_RSASha1SignatureService_getSignature).startFuzz()
}