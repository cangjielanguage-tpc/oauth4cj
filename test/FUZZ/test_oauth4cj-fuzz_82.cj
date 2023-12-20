// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*
from std import io.*

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