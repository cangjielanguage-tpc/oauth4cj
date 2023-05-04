// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    /***
        返回与构造器一直
    ***/
    @TestCase
    func testOAuth4cjRequesttoString01(): Unit {
        var verbs=Array<Verb>([Verb.GET,Verb.POST,Verb.PUT,Verb.DELETE,Verb.HEAD,Verb.OPTIONS,Verb.TRACE,Verb.PATCH])
        for (verb in verbs){
            for (url in strValues){
                var oauth4cjRequest=OAuth4cjRequest(verb,url)
                @Assert(oauth4cjRequest.toString(),"@Request(${oauth4cjRequest.getVerb()} ${oauth4cjRequest.getUrl()})")
            }
        }
    }
}