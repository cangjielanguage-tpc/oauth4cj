// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestURLEncoderB001{
    /***
        编码后变化的字符：
        1.空格替换为“+”
        2.所有其他字符都不安全，并且首先使用一些编码方案将其转换为一个或多个字节。 然后每个字节由3个字符串“ %xy ”表示，其中xy是字节的两位十六进制表示。
    ***/
	public var params=Array<String>([])
    public var re=""

    @TestCase
    func testURLEncoderEncode0102(): Unit {
        re=URLEncoder.encode(" !\"#$%&\'()*+,/~")
        @Assert(re,"+%21%22%23%24%25%26%27%28%29*%2B%2C%2F%7E")
    }
}