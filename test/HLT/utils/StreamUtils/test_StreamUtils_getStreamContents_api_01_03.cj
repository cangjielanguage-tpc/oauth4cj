// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var re="not empty"

 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents0103(): Unit {
        input=ByteArrayStream()
        var exp_flag_01=0
        try{
            re=StreamUtils.getStreamContents(input,isGzipStream:true)
        }catch(e:OAuth4cjException){

            if(e.toString().contains("Unable to obtain decompressed string from an empty InputStream")){
                exp_flag_01=1
            }
        }
        @Assert(exp_flag_01,1)

        input=ByteArrayStream(1024)
        var exp_flag_02=0
        try{
             re=StreamUtils.getStreamContents(input,isGzipStream:true)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Unable to obtain decompressed string from an empty InputStream")){
                exp_flag_02=1
            }
        }
        @Assert(exp_flag_02,1)
    }   
}