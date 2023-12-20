// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_DeviceAuthorization_setIntervalSeconds(dp:DataProvider):Int32 {
    var testDeviceAuthorization=DeviceAuthorization("deviceCode","userCode","verificationUri",1024)
    try{
        testDeviceAuthorization.setIntervalSeconds(dp.consumeInt32())
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_DeviceAuthorization_setIntervalSeconds).startFuzz()
}