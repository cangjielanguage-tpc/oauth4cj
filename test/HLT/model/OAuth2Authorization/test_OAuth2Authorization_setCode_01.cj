// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth2AuthorizationB001{
    //单/多次设置
    @TestCase
    func testOAuth2AuthorizationSetCode01(): Unit {
        var oa01=OAuth2Authorization()
        for (i in strValues){
            oa01.setCode(i)
            @Assert(oa01.getCode(),i)
        }
    }
}