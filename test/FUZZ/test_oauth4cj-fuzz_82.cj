// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*
import std.io.*

public func fuzzFunc_Response_Init02(dp:DataProvider):Int32 {
    var stream=ByteArrayStream()
    try{
        Response(dp.consumeInt32(),dp.consumeString(1024),HashMap<String, String>(),stream,ArrayList<Resource>())
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_Response_Init02).startFuzz()
}