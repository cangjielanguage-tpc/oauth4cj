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
        1.verb.isPermirBody()==true
        2.verb.isPermirBody()==false
    ***/
    @TestCase
    func testOAuth4cjRequestaddParameter01(): Unit {
        var parameters=HashMap<String,String>([("oauth_1",""),("oauth_","oauth_"),("scope","scope01"),("realm","realm01")])
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var oauth4cjRequest02=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        for (parameter in parameters){
            oauth4cjRequest01.addParameter(parameter[0],parameter[1])
            oauth4cjRequest02.addParameter(parameter[0],parameter[1])
        }
        @Assert(oauth4cjRequest01.getQueryStringParams().asFormUrlEncodedString(),ParameterList(parameters).asFormUrlEncodedString())
        @Assert(oauth4cjRequest01.getBodyParams().asFormUrlEncodedString(),"")
        @Assert(oauth4cjRequest02.getQueryStringParams().asFormUrlEncodedString(),"")
        @Assert(oauth4cjRequest02.getBodyParams().asFormUrlEncodedString(),ParameterList(parameters).asFormUrlEncodedString())
    }
}