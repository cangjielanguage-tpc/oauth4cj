// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
from std import random.*

@Test
public class TestBaseUtilsV002{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：长度是3的倍数
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding03(): Unit {
        params=Array<UInt8>(10000,item:0)
        var random=Random()
        for (i in 0..9){
             params[i]=random.nextUInt8()
        }
        re=Base64Utils.encodeUrlWithoutPadding(params)
        var exp_re=toBase64String(params).replace("+","-")
        exp_re=exp_re.replace("/","_")
        exp_re=exp_re.replace("=","")
        @Assert(re,exp_re)
    }
}   