// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import services.*

@Test
public class TestPlaintextSignatureServiceB004{
    /***
        public func getSignatureMethod(): String
        测试场景:均返回PLAINTEXT
    ***/
    @TestCase
    func testPlaintextSignatureServiceGetSignatureMethod01(): Unit {
        let plSS=PlaintextSignatureService()
        let re=plSS.getSignatureMethod()
        @Assert(re,"PLAINTEXT")
    }
}