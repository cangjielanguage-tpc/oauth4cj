// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartUtilsB005{
    /***
        public static func generateDefaultBoundary(): String
        测试场景:返回值准确
    ***/
    @TestCase
    func testMultipartUtilsGenerateDefaultBoundary01(): Unit {
        var defaultboundary=MultipartUtils.generateDefaultBoundary()
        @Assert(defaultboundary.contains("----OAuth4cj----"),true)
    }
}