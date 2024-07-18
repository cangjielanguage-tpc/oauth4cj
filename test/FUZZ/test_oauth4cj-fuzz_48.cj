// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_DeviceAuthorization_setVerificationUriComplete(dp:DataProvider):Int32 {
    var testDeviceAuthorization=DeviceAuthorization("deviceCode","userCode","verificationUri",1024)
    try{
        testDeviceAuthorization.setVerificationUriComplete(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_DeviceAuthorization_setVerificationUriComplete).startFuzz()
}