// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from oauth4cj import exceptions.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    /***
        异常设置
        可允许设置的范围：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testOAuth4cjRequestsetCharset01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var charsets=Array<String>(["unicode","gbk ","GBK","gb2312"])
        var flag=1
        for (charset in charsets){
            flag=1
            try{
                oauth4cjRequest.setCharset(charset)
            }catch(e:OAuth4cjException){
                if(e.toString().contains("only supperd UTF-8")){
                    flag=0
                }
            }
            @Assert(flag,0)
        }
    }
}