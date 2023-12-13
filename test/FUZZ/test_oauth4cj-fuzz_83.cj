// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*
from std import io.*

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