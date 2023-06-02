// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuthConstantsB001{
    @TestCase
    func testOAuthConstantsValueOath1001(): Unit {
        @Assert(OAuthConstants.OOB,"oob")
    }
}
