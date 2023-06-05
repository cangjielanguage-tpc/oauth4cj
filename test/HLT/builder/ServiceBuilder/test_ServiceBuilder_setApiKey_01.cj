// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
/*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
*/
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setApiKey(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuilderSetApiKey01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var flag=1
        try{
            serviceBuilder01.setApiKey("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setApiKey("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}