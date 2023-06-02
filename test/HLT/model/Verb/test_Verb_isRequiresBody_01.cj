// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestVerbB001{
    @TestCase
    func testIsRequiresBody01(): Unit {
        @Assert(Verb.GET.isRequiresBody(),false)
        @Assert(Verb.POST.isRequiresBody(),true)
        @Assert(Verb.PUT.isRequiresBody(),true)
        @Assert(Verb.DELETE.isRequiresBody(),false)
        @Assert(Verb.HEAD.isRequiresBody(),false)
        @Assert(Verb.OPTIONS.isRequiresBody(),false)
        @Assert(Verb.TRACE.isRequiresBody(),false)
        @Assert(Verb.PATCH.isRequiresBody(),true)
    }
}