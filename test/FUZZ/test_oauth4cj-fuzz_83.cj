// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*
import std.io.*

public func fuzzFunc_Response_getHeader(dp:DataProvider):Int32 {
    var testResponse=Response(Int32(200),"message",HashMap<String, String>(),"body")
    try{
        testResponse.getHeader(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_Response_getHeader).startFuzz()
}