// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import services.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getTimestampService(): TimestampService
        测试场景:能生成TimestampService即可
    ***/
    @TestCase
    func testDefaultApi10aGetTimestampService01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let timestampService=subDefaultApi10a.getTimestampService()
        @Assert(timestampService is TimestampService,true)
        @Assert(timestampService is TimestampServiceImpl,true)
    }
}
