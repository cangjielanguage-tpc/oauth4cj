// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB001{
    /***
        返回与构造器一直
    ***/
    @TestCase
    func testOAuth4cjRequestgetVerb01(): Unit {
        var verbs=Array<Verb>([Verb.GET,Verb.POST,Verb.PUT,Verb.DELETE,Verb.HEAD,Verb.OPTIONS,Verb.TRACE,Verb.PATCH])
        for (verb in verbs){
            var oauth4cjRequest=OAuth4cjRequest(verb,"http://www.baidu.com")
            @Assert(oauth4cjRequest.getVerb().toString(),verb.toString())
        }
    }
}