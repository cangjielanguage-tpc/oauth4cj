// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
@Test
public class TestOAuth1RequestTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是非空,字符串能匹配到oauth_token=([^&]+),不能匹配到oauth_token_secret=([^&]*)
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract03(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body="oauth_token=abcsd&token_secret=&"
        var response01=Response(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenExtractor01.extract(response01)
        }catch(e:OAuth4cjException){

            if(e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}