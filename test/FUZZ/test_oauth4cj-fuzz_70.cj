// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_OAuth4cjRequest_initMultipartPayload03(dp:DataProvider):Int32 {
    var testOAuth4cjRequest =OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
    try{
        testOAuth4cjRequest.initMultipartPayload(dp.consumeString(1024),HashMap<String, String>())
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_OAuth4cjRequest_initMultipartPayload03).startFuzz()
}