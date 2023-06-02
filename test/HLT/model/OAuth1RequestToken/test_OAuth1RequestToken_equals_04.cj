// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1RequestTokenV001{
    /***
       测试项：(oauth1requesttoken02as OAuth1RequestToken)  不是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1RequestToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (index01 in strValues.size-1..0:-1) {
            for (index02 in 0..strValues.size){
                oauth1requesttoken01=OAuth1RequestToken(strValues[index01],strValues[index02])
                oauth1requesttoken02=OAuth1RequestToken(strValues[index01],strValues[index02],strValues[index02])
                @Assert(oauth1requesttoken02.equals(oauth1requesttoken01),true)
                @Assert(oauth1requesttoken01.equals(oauth1requesttoken02),true)

                for (boolValue in boolValues){
                    oauth1requesttoken03=OAuth1RequestToken(strValues[index02],strValues[index02],boolValue,strValues[index01])
                    if(strValues[index01]==strValues[index02]){
                        @Assert(oauth1requesttoken03.equals(oauth1requesttoken02),true)
                        @Assert(oauth1requesttoken02.equals(oauth1requesttoken03),true)
                        @Assert(oauth1requesttoken01.equals(oauth1requesttoken03),true)
                        @Assert(oauth1requesttoken03.equals(oauth1requesttoken01),true)
                    }else{
                        @Assert(oauth1requesttoken03.equals(oauth1requesttoken02),false)
                        @Assert(oauth1requesttoken02.equals(oauth1requesttoken03),false)
                        @Assert(oauth1requesttoken01.equals(oauth1requesttoken03),false)
                        @Assert(oauth1requesttoken03.equals(oauth1requesttoken01),false)
                    }
                }
            }
        }
    }
}
