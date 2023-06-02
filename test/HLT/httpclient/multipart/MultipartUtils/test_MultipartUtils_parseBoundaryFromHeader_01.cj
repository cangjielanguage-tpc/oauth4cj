// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartUtilsB005{
    /***
        public static func parseBoundaryFromHeader(contentTypeHeader: String): String
        测试场景:能匹配:"; boundary="?([0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?])"?"
    ***/
    @TestCase
    func testMultipartUtilsParseBoundaryFromHeader01(): Unit {
        var contentTypeHeader="; boundary=\"?(1111)\""
        var parseboundary=MultipartUtils.parseBoundaryFromHeader(contentTypeHeader)
        @Assert(parseboundary,"?(1111)")
    }
}