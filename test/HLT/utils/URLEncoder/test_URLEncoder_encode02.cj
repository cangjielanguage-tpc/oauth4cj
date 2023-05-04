// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
from oauth4cj import model.*
from oauth4cj import exceptions.*
@Test
public class TestURLEncoder01{
    /***
        正常编码的enc：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
	public var enc_params=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
    public var re=""

    @TestCase
    func testURLEncoderEncode02(): Unit {
        var param="abcdefghijklmnopqrstuvwxyz"
        for (enc in enc_params){
            re=URLEncoder.encode(param,enc)
            @Assert(re,param)
        }
    }
}