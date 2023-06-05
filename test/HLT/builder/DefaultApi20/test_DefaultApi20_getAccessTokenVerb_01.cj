// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi20B004{
    /***
        public func getAccessTokenVerb(): Verb
        测试场景:默认均返回Verb.POST
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenVerb01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getAccessTokenVerb().toString(),Verb.POST.toString())
    }
}