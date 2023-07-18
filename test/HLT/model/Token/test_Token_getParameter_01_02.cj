// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //本类实例: 无&,仅有一个参数:http://www.baidu.com?userName=fly
    @TestCase
    func testGetParameter0102(): Unit {
        var token01=Token("http://www.baidu.com?userName=fly")
        var token02=Token("http://www.baidu.com?userName=")
        var token03=Token("http://www.baidu.com?=fly")
        var token04=Token("http://www.baidu.com?fly")
        @Assert(token01.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(token02.getParameter("userName"),"")
        @Assert(token03.getParameter(""),"")
        @Assert(token03.getParameter("=fly"),"")
        @Assert(token04.getParameter("fly"),"")
    }
}