// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


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
            if(e.toString().contains("OAuth4cjException: Unable to obtain decompressed string from an empty InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }
 	//is有内容,返回字符串准确
    @TestCase
    func testGetGzipStreamContents02(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        gzipinput=CompressInputStream(input,wrap:GzipFormat)
        re=StreamUtils.getGzipStreamContents(gzipinput)
        @Assert(re,str)
    }
 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents01(): Unit {
        input=ByteArrayStream()
        var exp_flag=0
        try{
            re=StreamUtils.getStreamContents(input)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

        input=ByteArrayStream(1024)
        exp_flag=0
        try{
             re=StreamUtils.getStreamContents(input)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }
 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents0102(): Unit {
        input=ByteArrayStream()
        var exp_flag=0
        try{
            re=StreamUtils.getStreamContents(input,isGzipStream:false)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

        input=ByteArrayStream(1024)
        exp_flag=0
        try{
             re=StreamUtils.getStreamContents(input,isGzipStream:false)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

    }
 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents0103(): Unit {
        input=ByteArrayStream()
        var exp_flag_01=0
        try{
            re=StreamUtils.getStreamContents(input,isGzipStream:true)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Unable to obtain decompressed string from an empty InputStream")){
                exp_flag_01=1
            }
        }
        @Assert(exp_flag_01,1)

        input=ByteArrayStream(1024)
        var exp_flag_02=0
        try{
             re=StreamUtils.getStreamContents(input,isGzipStream:true)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: Unable to obtain decompressed string from an empty InputStream")){
                exp_flag_02=1
            }
        }
        @Assert(exp_flag_02,1)
    }
 	//is有内容,返回字符串准确
    @TestCase
    func testGetStreamContents02(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        re=StreamUtils.getStreamContents(input)
        @Assert(re,str)
    }
 	//is有内容,返回字符串准确
    @TestCase
    func testGetStreamContents03(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        re=StreamUtils.getStreamContents(input,isGzipStream:false)
        @Assert(re,str)
    }
 	//is有内容,返回字符串准确
    @TestCase
    func testGetStreamContents04(): Unit {
        input=ByteArrayStream()
        var str="hello cangjie"
        var arr=str.toUtf8Array()
        input.write(arr)
        re=StreamUtils.getStreamContents(input,isGzipStream:true)
        @Assert(re,str)
    }
}