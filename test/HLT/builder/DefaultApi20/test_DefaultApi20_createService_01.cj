// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import httpclient.*
from std import io.*
@Test
public class TestDefaultApi20B004{
    /***
        public func createService(apiKey: String, apiSecret: String, callback: String, defaultScope: String,responseType: String, debugStream: ?OutputStream, userAgent: String, httpClientConfig: ?HttpClientConfig,httpClient: ?HttpClient):OAuth20Service
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20CreateService01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let debugStream=Option<OutputStream>.None
        let httpClientConfig=Option<HttpClientConfig>.None
        let httpClient=Option<HttpClient>.None
        let oAuth20Service=subDefaultApi20.createService(str_common,str_common,str_common,str_common,str_common,debugStream,str_common,httpClientConfig,httpClient)
        @Assert(oAuth20Service is OAuth20Service,true)
    }
}
