// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*

@Test
public class TestOAuthEncoder01{
	
    /***
        包含特殊字符
    ***/
	public var params=Array<String>([" ","*","~"])
    public var res=Array<String>(["%20","%2A","~"])
    public var re=""
    @TestCase
    func testOAuthEncoderEncode01(): Unit {
        for (index in 0..params.size){
            re=OAuthEncoder.encode(params[index])
            @Assert(re,res[index])
        }
    }
}   