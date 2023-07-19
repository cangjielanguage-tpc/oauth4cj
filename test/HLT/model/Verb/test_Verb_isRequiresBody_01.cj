// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


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