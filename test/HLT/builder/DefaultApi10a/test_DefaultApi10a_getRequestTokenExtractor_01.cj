// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*
from oauth4cj import extractors.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken>
        测试场景:能生成HHeaderExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetHeaderExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenExtractor=subDefaultApi10a.getRequestTokenExtractor()
        @Assert(requestTokenExtractor is TokenExtractor<OAuth1RequestToken>,true)
        @Assert(requestTokenExtractor is OAuth1RequestTokenExtractor,true)
    }
}
