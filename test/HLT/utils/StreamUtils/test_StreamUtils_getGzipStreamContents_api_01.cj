// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var gzipinput=CompressInputStream(input,wrap:GzipFormat)
    public var re="not empty"

 	//is无内容,返回字符串准确
    @TestCase
    func testGetGzipStreamContents01(): Unit {
        input=ByteArrayStream()
        gzipinput=CompressInputStream(input,wrap:GzipFormat)
        var exp_flag=0
        try{
            re=StreamUtils.getGzipStreamContents(gzipinput)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Unable to obtain decompressed string from an empty InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }  
}