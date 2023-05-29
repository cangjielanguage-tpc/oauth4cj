// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1TokenV001{
    /***
       测试项：调用源
       测试场景： 本类对象调用,返回true
    ***/
    @TestCase
    func testIsEmpty01(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token()
        var oauth1token03=OAuth1Token()
        @Assert(oauth1token01.isEmpty(),true)
        for (index01 in 0..strValues.size) {
            for (index02 in strValues.size-1..-1:-1) {
                oauth1token02=OAuth1Token(strValues[index01],strValues[index02],strValues[index01])
                oauth1token03=OAuth1Token(strValues[index01],strValues[index02],"not empty")
                if(strValues[index01]=="" && strValues[index02]==""){
                    @Assert(oauth1token02.isEmpty(),true)
                    @Assert(oauth1token03.isEmpty(),true)
                }else{
                    @Assert(oauth1token02.isEmpty(),false)
                    @Assert(oauth1token03.isEmpty(),false)
                }
            }
        }
    }
}