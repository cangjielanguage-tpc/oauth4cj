// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_ByteArrayBodyPartPayload_Init(dp:DataProvider):Int32 {
    try{
        ByteArrayBodyPartPayload(dp.consumeUInt8s(1024),dp.consumeInt64(),dp.consumeInt64(),HashMap<String, String>())
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_ByteArrayBodyPartPayload_Init).startFuzz()
}