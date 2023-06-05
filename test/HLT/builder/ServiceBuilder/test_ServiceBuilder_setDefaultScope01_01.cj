// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0101(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var flag=1
        try{
            serviceBuilder01.setDefaultScope("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setDefaultScope(" ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid OAuth scope")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}