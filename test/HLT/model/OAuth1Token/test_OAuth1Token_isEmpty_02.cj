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
       测试场景： 子类OAuth1AccessToken对象调用,返回true
    ***/
    @TestCase
    func testIsEmpty02(): Unit {
        var subOauth1token01=OAuth1AccessToken("123","123")
        var subOauth1token02=OAuth1AccessToken("123","123")
        var subOauth1token03=OAuth1AccessToken("123","123")
        for (index01 in 0..strValues.size) {
            for (index02 in strValues.size-1..-1:-1) {
                subOauth1token01=OAuth1AccessToken(strValues[index01],strValues[index02])
                subOauth1token02=OAuth1AccessToken(strValues[index01],strValues[index02],strValues[index01])
                subOauth1token03=OAuth1AccessToken(strValues[index01],strValues[index02],"not empty")
                if(strValues[index01]=="" && strValues[index02]==""){
                    @Assert(subOauth1token01.isEmpty(),true)
                    @Assert(subOauth1token02.isEmpty(),true)
                    @Assert(subOauth1token03.isEmpty(),true)
                }else{
                    @Assert(subOauth1token01.isEmpty(),false)
                    @Assert(subOauth1token02.isEmpty(),false)
                    @Assert(subOauth1token03.isEmpty(),false)
                }
            }
        }
    }
}