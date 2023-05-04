// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuthConstantsV001{
    @TestCase
    func testOAuthConstantsValueOath1001(): Unit {
        @Assert(OAuthConstants.OOB,"oob")
    }
}
