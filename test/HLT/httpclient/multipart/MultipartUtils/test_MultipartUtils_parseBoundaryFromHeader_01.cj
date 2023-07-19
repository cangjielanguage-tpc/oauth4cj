// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

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