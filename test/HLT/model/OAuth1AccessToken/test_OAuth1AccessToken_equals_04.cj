// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1AccessTokenV001{
    /***
       测试项：(obj as OAuth1AccessToken)  不是  Option<OAuth1AccessToken>.None
       测试场景： object是OAuth1AccessToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken0102=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")
        var oauth1accesstoken0202=OAuth1AccessToken("123","123")
        for (index01 in strValues.size-1..0:-1) {
            for (index02 in 0..strValues.size){
                oauth1accesstoken01=OAuth1AccessToken(strValues[index01],strValues[index02])
                oauth1accesstoken0102=OAuth1AccessToken(strValues[index02],strValues[index01])
                oauth1accesstoken02=OAuth1AccessToken(strValues[index01],strValues[index02],strValues[index02])
                oauth1accesstoken0202=OAuth1AccessToken(strValues[index01],strValues[index02],strValues[index01])
                @Assert(oauth1accesstoken02.equals(oauth1accesstoken01),true)
                @Assert(oauth1accesstoken0202.equals(oauth1accesstoken01),true)
                if(strValues[index02] == strValues[index01]){
                    @Assert(oauth1accesstoken01.equals(oauth1accesstoken0102),true)
                    @Assert(oauth1accesstoken02.equals(oauth1accesstoken0102),true)
                    @Assert(oauth1accesstoken0202.equals(oauth1accesstoken0102),true)
                }else{
                    @Assert(oauth1accesstoken01.equals(oauth1accesstoken0102),false)
                    @Assert(oauth1accesstoken02.equals(oauth1accesstoken0102),false)
                    @Assert(oauth1accesstoken0202.equals(oauth1accesstoken0102),false)
                }
            }
        }
    }
}
