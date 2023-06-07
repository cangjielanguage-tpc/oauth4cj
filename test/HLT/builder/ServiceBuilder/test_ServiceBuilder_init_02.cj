// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public init(apiKey: String)
        测试场景:字符串是否是空白字符串-否
    ***/
    @TestCase
    func testServiceBuilderInit02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        var oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        serviceBuilder01=ServiceBuilderOAuth10a("str")
        oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        //@Assert(oauth10aService.getApiKey(),"str")//B004暂未提供后续版本提供
        @Assert(oauth10aService is OAuth10aService,true)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        var oauth20Service=serviceBuilder02.build(subDefaultApi20)
        serviceBuilder02=ServiceBuilderOAuth20("str")
        oauth20Service=serviceBuilder02.build(subDefaultApi20)
        //@Assert(oauth10aService.getApiKey(),"str")//B004暂未提供后续版本提供
        @Assert(oauth20Service is OAuth20Service,true)
    }
}