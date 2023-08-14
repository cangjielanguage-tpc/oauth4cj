// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


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