// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
@Test
public class TestPreconditions03{
    public var params=Array<String>()
 	//str仅包含空白字符：空字符串，空格(中英文)，\n,\r,\t,\f，返回false  \v,"\b","\0","\0\0"
    @TestCase
    func testHasText01(): Unit {
        params=Array<String>([""," ","\n","\r","\t","\f","\v"])
        for (param in params){
            @Assert(Preconditions.hasText(param),false)
        }
        params=Array<String>(["\b","\0","\0\0"])
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
} 