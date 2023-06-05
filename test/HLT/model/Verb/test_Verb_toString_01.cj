// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestVerbB001{
    @TestCase
    func testToString01(): Unit {
        @Assert(Verb.GET.toString(),"GET")
        @Assert(Verb.POST.toString(),"POST")
        @Assert(Verb.PUT.toString(),"PUT")
        @Assert(Verb.DELETE.toString(),"DELETE")
        @Assert(Verb.HEAD.toString(),"HEAD")
        @Assert(Verb.OPTIONS.toString(),"OPTIONS")
        @Assert(Verb.TRACE.toString(),"TRACE")
        @Assert(Verb.PATCH.toString(),"PATCH")
    }
}