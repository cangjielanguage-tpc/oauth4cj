// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
@Test
public class TestPreconditions01{
    public var params=""
    public var errorMsg=""
    @TestCase
    func testCheckEmptyString03(): Unit {
        //hasText(string)==false && hasText(errorMsg）==true,抛异常，打印异常信息显示字符串errorMsg
        params=""
        errorMsg=""
        var act_errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(params,errorMsg)
        }catch(e:Exception){
            flag=0
            act_errorMsg=e.toString()
        }
        @Assert(flag,0)
        @Assert(act_errorMsg.contains("Received an invalid parameter"),true)
        
    }                      
}