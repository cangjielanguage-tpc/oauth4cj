// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB001{
    /***
        添加成功
        1.key,startsWith("oauth_")
        2.key.equals("scope")
        3.key.equals("realm")
    ***/
    @TestCase
    func testOAuth4cjRequestaddOAuthParameter01(): Unit {
        var parameters=HashMap<String,String>([("oauth_1",""),("oauth_","oauth_"),("scope","scope01"),("realm","realm01")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (parameter in parameters){
            oauth4cjRequest.addOAuthParameter(parameter[0],parameter[1])
        }
        @Assert(oauth4cjRequest.getOauthParameters(),parameters)
    }
}