// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB001{
    /***
        初始化查询：url不带参数，url无效协议
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams0102(): Unit {
        var url="sss://www.baidu.com"
        var exp_flag=0
        try{
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
            @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),"")
        }catch(e:Exception){
            if(e.toString().contains("Malformed URL")){
                 exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }
}