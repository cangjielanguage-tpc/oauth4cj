// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartUtilsB005{
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为空
    ***/
    @TestCase
    func testMultipartUtilsGetPayload01(): Unit {
        var  header=HashMap<String,String>([("key01","value01")])
        var  multipartPayload=MultipartPayload("subtype","boundary",header)
        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
}