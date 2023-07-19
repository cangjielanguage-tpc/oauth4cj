// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var re="not empty"

 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents0102(): Unit {
        input=ByteArrayStream()
        var exp_flag=0
        try{
            re=StreamUtils.getStreamContents(input,isGzipStream:false)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

        input=ByteArrayStream(1024)
        exp_flag=0
        try{
             re=StreamUtils.getStreamContents(input,isGzipStream:false)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

    }
}