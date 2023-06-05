// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder
        测试场景:验证字符串是否为空-设置后调用
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var subDefaultApi10a=SubDefaultApi10a()

        let apiSecret="hello cangjie"

        serviceBuilder01.setApiSecret(apiSecret)
        let oauth10aService01=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService01.getApiSecret(),apiSecret)

        serviceBuilder01.setApiSecretIsEmptyStringUnsafe()
        let oauth10aService02=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService02.getApiSecret(),"")
    }
}