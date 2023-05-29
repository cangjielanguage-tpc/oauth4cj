// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth2AccessTokenV001{
    /***
       测试项：(oauth2accesstoken02as OAuth2AccessToken)  不是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken0102=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken0202=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        var oauth2accesstoken0302=OAuth2AccessToken("123")
        var oauth2accesstoken0303=OAuth2AccessToken("123")
        for (index01 in strValues.size-1..0:-1) {
            for (index02 in 0..strValues.size){
                oauth2accesstoken01=OAuth2AccessToken(strValues[index01])
                oauth2accesstoken0102=OAuth2AccessToken(strValues[index01])
                oauth2accesstoken02=OAuth2AccessToken(strValues[index01],strValues[index02])
                oauth2accesstoken0202=OAuth2AccessToken(strValues[index01],strValues[index02])
                @Assert(oauth2accesstoken01.equals(oauth2accesstoken0102),true)
                @Assert(oauth2accesstoken01.equals(oauth2accesstoken02),true)
                @Assert(oauth2accesstoken02.equals(oauth2accesstoken0202),true)
                @Assert(oauth2accesstoken02.equals(oauth2accesstoken01),true)
                for (int32Value in int32Values){
                    oauth2accesstoken03=OAuth2AccessToken(strValues[index01],strValues[index01],int32Value,strValues[index01],strValues[index01],strValues[index01])
                    oauth2accesstoken0302=OAuth2AccessToken(strValues[index01],strValues[index01],int32Value,strValues[index01],strValues[index01],strValues[index02])
                    oauth2accesstoken0303=OAuth2AccessToken(strValues[index02],strValues[index02],int32Value,strValues[index02],strValues[index02],strValues[index02])

                    @Assert(oauth2accesstoken03.equals(oauth2accesstoken0302),true)

                    if(index01==index02){
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken0303),true)
                          if(strValues[index02]==""){
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken02),true)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken0202),true)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken01),true)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken0102),true)
                          }else{
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken02),false)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken0202),false)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken01),false)
                              @Assert(oauth2accesstoken03.equals(oauth2accesstoken0102),false)
                          }
                    }else {
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken0303),false)
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken02),false)
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken0202),false)
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken01),false)
                          @Assert(oauth2accesstoken03.equals(oauth2accesstoken0102),false)
                    }
                }
            }
        }
    }
}
