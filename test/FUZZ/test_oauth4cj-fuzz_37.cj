// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_PKCEService_generatePKCE(dp:DataProvider):Int32 {
    var testPKCEService=PKCEService(Int32(1234))
    try{
        testPKCEService.generatePKCE(dp.consumeUInt8s(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_PKCEService_generatePKCE).startFuzz()
}