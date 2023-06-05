// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public init(apiKey: String)
        测试场景:字符串是否是空白字符串-是
    ***/
    @TestCase
    func testServiceBuilderInit01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var flag=1
        try{
            serviceBuilder01=ServiceBuilder("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01=ServiceBuilder("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}