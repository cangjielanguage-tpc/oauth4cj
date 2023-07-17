// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var re="not empty"

 	//is有内容,返回字符串准确
    @TestCase
    func testGetStreamContents02(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        re=StreamUtils.getStreamContents(input,isGzipStream:false)
        @Assert(re,str)
    }       
}