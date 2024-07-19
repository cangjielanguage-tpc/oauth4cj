// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_Preconditions_hasText(dp:DataProvider):Int32 {
    try{
        Preconditions.hasText(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_Preconditions_hasText).startFuzz()
    0
}