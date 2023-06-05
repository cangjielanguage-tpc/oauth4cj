// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB001{
    @TestCase
    func testOAuth4cjRequestgetFilePayload01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var flag=1
        try{
            oauth4cjRequest.getFilePayload().getOrThrow()
        }catch(e:NoneValueException){
            flag=0
        }
        @Assert(flag,0)
    }
}