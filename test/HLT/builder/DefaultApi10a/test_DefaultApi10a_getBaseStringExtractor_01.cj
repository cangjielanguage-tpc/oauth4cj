// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import extractors.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getBaseStringExtractor(): BaseStringExtractor
        测试场景:能生成BaseStringExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetBaseStringExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let baseStringExtractor=subDefaultApi10a.getBaseStringExtractor()
        @Assert(baseStringExtractor is BaseStringExtractor,true)
        @Assert(baseStringExtractor is BaseStringExtractorImpl,true)
    }
}
