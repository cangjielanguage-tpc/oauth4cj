// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
from oauth4cj import oauth4cj.*
from std import collection.*

public func fuzzFunc_OAuth2Error_parseFrom(dp:DataProvider):Int32 {
    try{
        OAuth2Error.parseFrom(dp.consumeString(300))//服务器错误信息一般不会很长
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_OAuth2Error_parseFrom).startFuzz()
}