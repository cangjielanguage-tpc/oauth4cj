// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


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