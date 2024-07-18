// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj

from fuzz import fuzz.*
public import oauth4cj.*
import std.collection.*

public func fuzzFunc_ParameterList_addQuerystring(dp:DataProvider):Int32 {
    var testParameterList =ParameterList()
    try{
        testParameterList.addQuerystring(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}

main(){
    Fuzzer(fuzzFunc_ParameterList_addQuerystring).startFuzz()
}