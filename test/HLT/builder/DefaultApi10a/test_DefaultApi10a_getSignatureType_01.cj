// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getSignatureType(): OAuth1SignatureType
        测试场景:能生成OAuth1SignatureType即可
    ***/
    @TestCase
    func testDefaultApi10aGetSignatureType01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let signatureType=subDefaultApi10a.getSignatureType()
        @Assert(signatureType.toString(),"HEADER")
    }
}
