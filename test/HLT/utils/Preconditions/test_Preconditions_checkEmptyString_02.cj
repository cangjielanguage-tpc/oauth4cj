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
    func testCheckEmptyString02(): Unit {
        //hasText(string)==true && hasText(errorMsg）==false不报错无任何信息
        params="rerwr"
        errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(params,errorMsg)
        }catch(e:Exception){
            flag=0
        }
        @Assert(flag,1)        
    }                       
}