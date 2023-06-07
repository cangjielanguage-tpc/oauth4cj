// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecret(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01.setApiSecret("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api secret")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setApiSecret("    ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api secret")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setApiSecret("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api secret")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        flag02=1
        try{
            serviceBuilder02.setApiSecret("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api secret")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
}