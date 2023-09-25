// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_DeviceAuthorization_Init(dp:DataProvider):Int32 {
    try{
        DeviceAuthorization(dp.consumeString(1024),dp.consumeString(1024),dp.consumeString(1024),dp.consumeInt64())
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_DeviceAuthorization_Init).startFuzz()
}