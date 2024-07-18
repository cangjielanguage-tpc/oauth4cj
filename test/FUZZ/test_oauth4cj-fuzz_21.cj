// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_FileByteArrayBodyPartPayload_Init(dp:DataProvider):Int32 {
    try{
        FileByteArrayBodyPartPayload(dp.consumeUInt8s(1024),dp.consumeInt64(),dp.consumeInt64(),dp.consumeString(1024),dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_FileByteArrayBodyPartPayload_Init).startFuzz()
}