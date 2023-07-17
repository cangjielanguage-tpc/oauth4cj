// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //本类实例: 无&,且无参数,http://www.baidu.com?
    @TestCase
    func testGetParameter01(): Unit {
        var token01=Token()
        var token02=Token("")
        var token03=Token("http://www.baidu.com?")
        @Assert(token01.getParameter(""),"")
        @Assert(token02.getParameter(""),"")
        @Assert(token03.getParameter(""),"")
    }
}