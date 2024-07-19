// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_URLEncoder_decode(dp:DataProvider):Int32 {
    try{
        URLEncoder.decode(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_URLEncoder_decode).startFuzz()
    0
}