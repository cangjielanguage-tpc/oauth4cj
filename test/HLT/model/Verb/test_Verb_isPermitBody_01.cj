// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestVerbB001{
    @TestCase
    func testIsPermitBody01(): Unit {
        @Assert(Verb.GET.isPermitBody(),false)
        @Assert(Verb.POST.isPermitBody(),true)
        @Assert(Verb.PUT.isPermitBody(),true)
        @Assert(Verb.DELETE.isPermitBody(),true)
        @Assert(Verb.HEAD.isPermitBody(),false)
        @Assert(Verb.OPTIONS.isPermitBody(),false)
        @Assert(Verb.TRACE.isPermitBody(),false)
        @Assert(Verb.PATCH.isPermitBody(),true)
    }
}