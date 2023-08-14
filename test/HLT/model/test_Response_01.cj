// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestResponseB001{
    @TestCase
    func testResponseClose01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var file=File("temp.cj",OpenOption.CreateOrTruncate(true))
        var sub01=SubResource(file)
        var inputStream01=ByteArrayStream()
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
        response01.close()
        @Assert(file.isClosed(),false)
        try{
            response02.close()
            @Assert(file.isClosed(),true)
        }catch(e:FSException){
            @Assert(file.isClosed(),false)
        }
   }
    //无header
    @TestCase
    func testResponseGetBody01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
        for (str in strValues) {
            inputStream01=ByteArrayStream()
            inputStream01.write("hello byte".toUtf8Array())
            response01=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),str)
            response02=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
            @Assert(response01.getBody(),str)
            @Assert(response02.getBody(),"hello byte")
        }
    }
    //有header,header包含key：Content-Encoding,且value为“gzip”
    @TestCase
    func testResponseGetBody02(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        inputStream02.write("hello byte".toUtf8Array())
        var gzipinput=CompressInputStream(inputStream01,wrap:GzipFormat)
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),gzipinput,ArrayList<Resource>([sub01]))
        var response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream02,ArrayList<Resource>([sub01]))
        var exp_flag=0
        try{
           response03.getBody()
        }catch(e:Exception){
           if(e.toString().contains(" Decompressing data error")){
                exp_flag=1
           }
        }
        @Assert(exp_flag,1)
        @Assert(response01.getBody(),"body")
        @Assert(response02.getBody(),"hello byte")
    }
    //有header,其他
    @TestCase
    func testResponseGetBody0202(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream01,ArrayList<Resource>([sub01]))
        var response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),inputStream02,ArrayList<Resource>([sub01]))

        var encodingContent=Array<String>(["GZIP","Gzip","abgzip","gzip01","other"])
        for (encodeingValue in encodingContent){
            inputStream01=ByteArrayStream()
            inputStream01.write("hello byte".toUtf8Array())
            response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),"body")
            response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),inputStream01,ArrayList<Resource>([sub01]))
            response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding",encodeingValue)]),inputStream02,ArrayList<Resource>([sub01]))
        }

        @Assert(response01.getBody(),"body")
        @Assert(response02.getBody(),"hello byte")
        var exp_flag=0
        try{
            response03.getBody()
        }catch(e:Exception){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }
    //init32Values等价类
    @TestCase
    func testResponseGetCode01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello byte".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
        var response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
        var str="not emnpty"
        for (int32Value in int32Values) {
            response01=oauth4cj.model.Response(int32Value,str,HashMap<String,String>(),str)
            response02=oauth4cj.model.Response(int32Value,str,HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
            response03=oauth4cj.model.Response(int32Value,str,HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
            @Assert(response01.getCode(),int32Value)
            @Assert(response02.getCode(),int32Value)
            @Assert(response03.getCode(),int32Value)
        }
    }
    //name是/不是map的key之一
    @TestCase
    func testResponseGetHeader01(): Unit {
        var headers01=getHashMapByLength(10)
        var response01=oauth4cj.model.Response(Int32(2),"message",headers01,"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var response02=oauth4cj.model.Response(Int32(2),"message",headers01,inputStream01,ArrayList<Resource>([sub01]))
        for (i in 0..headers01.size){
            @Assert(response01.getHeader(i.toString()),i.toString())
            @Assert(response02.getHeader(i.toString()),i.toString())
        }
        var flag_response01=0
        var flag_response02=0
        try{
            response01.getHeader("11")
        }catch(e:Exception){
            flag_response01=1
        }
        @Assert(flag_response01,1)
        try{
            response02.getHeader("11")
        }catch(e:Exception){
            flag_response02=1
        }
        @Assert(flag_response02,1)
    }
    //构造器该字段为非空map.10/100个元素
    @TestCase
    func testResponseGetHeaders01(): Unit {
        var response01_10=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(10),"body")
        var response01_100=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(100),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var response02_10=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(10),inputStream01,ArrayList<Resource>([sub01]))
        var response02_100=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(100),inputStream01,ArrayList<Resource>([sub01]))

        var headers01=response01_10.getHeaders()
        var headers02=response01_100.getHeaders()
        var headers03=response02_10.getHeaders()
        var headers04=response02_100.getHeaders()
        @Assert(headers01.size,10)
        @Assert(headers02.size,100)
        @Assert(headers03.size,10)
        @Assert(headers04.size,100)
        for (i in 0..headers01.size){
            @Assert(headers01.get(i.toString()).getOrThrow(),i.toString())
            @Assert(headers03.get(i.toString()).getOrThrow(),i.toString())
        }
        for (i in 0..headers02.size){
            @Assert(headers02.get(i.toString()).getOrThrow(),i.toString())
            @Assert(headers04.get(i.toString()).getOrThrow(),i.toString())
        }
    }
    @TestCase
    func testResponseGetMessage01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var inputStream02=ByteArrayStream()
        inputStream01.write("hello byte".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
        var response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream02,ArrayList<Resource>([sub01]))

        for (str in strValues) {
            response01=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),str)
            response02=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
            response03=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),inputStream02,ArrayList<Resource>([sub01]))
            @Assert(response01.getMessage(),str)
            @Assert(response02.getMessage(),str)
            @Assert(response03.getMessage(),str)
        }
    }
    //stream的几种情况,构造器是否传入以及传入是否为空
    @TestCase
    func testResponseGetStream01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello byte".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
        var response03=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
        for (str in strValues) {
            inputStream=ByteArrayStream()
            inputStream.write("hello byte".toUtf8Array())
            response01=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),str)
            response02=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
            response03=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),ByteArrayStream(),ArrayList<Resource>([sub01]))
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response01.getStream())),"")
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response02.getStream())),"hello byte")
            @Assert(String.fromUtf8(getDataArrayFromInputStream(response03.getStream())),"")
        }
    }
    //code>=200 && code <400
    @TestCase
    func testResponseIsSuccessful01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))

        var isSuccessfuls=Array<(Int32,Bool)>([(-1,false),
                                              (0,false),
                                              (199,false),
                                              (200,true),
                                              (201,true),
                                              (300,true),
                                              (399,true),
                                              (400,false),
                                              (Int32.Max,false)])
        var str="ceshi"
        for (i in 0..isSuccessfuls.size){
            response01=oauth4cj.model.Response(isSuccessfuls[i][0],str,HashMap<String,String>(),str)
            response02=oauth4cj.model.Response(isSuccessfuls[i][0],str,HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
            @Assert(response01.isSuccessful(),isSuccessfuls[i][1])
            @Assert(response02.isSuccessful(),isSuccessfuls[i][1])
        }
    }
    //无header
    @TestCase
    func testResponsetoString01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("temp.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        inputStream01.write("hello world".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))

        for (str in strValues) {
            response01=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),str)
            inputStream01.write("hello world".toUtf8Array())
            response02=oauth4cj.model.Response(Int32(32),str,HashMap<String,String>(),inputStream01,ArrayList<Resource>([sub01]))
            var tostring_response01="Response{"+ "code=" + response01.getCode().toString()+ ", message='" + response01.getMessage() + '\'' + ", body='" + response01.getBody() + '\''+ ", headers=" + response01.getHeaders().toString() + "}"
            var tostring_response02="Response{"+ "code=" + response02.getCode().toString()+ ", message='" + response02.getMessage() + '\'' + ", body='" + response02.getBody() + '\''+ ", headers=" + response02.getHeaders().toString() + "}"
            @Assert(response01.toString(),tostring_response01)
            @Assert(response02.toString(),tostring_response02)
        }
    }
}

public func getHashMapByLength(length:Int64):HashMap<String,String>{
    var hashmap=HashMap<String,String>()
    for (i in 0..length){
        hashmap.put(i.toString(),i.toString())
    }
    return hashmap
}
public func getDataArrayFromInputStream(input:InputStream):Array<UInt8>{
     var read=1
     var outbuf_temp=Array<UInt8>(1024,item:0)
     var outbuf_arrlist=ArrayList<UInt8>()
     while(read>0){
         read=input.read(outbuf_temp)
         if(read!=0){
             outbuf_arrlist.appendAll(outbuf_temp[0..read])
         }
     }
     var out_final=Array<UInt8>(outbuf_arrlist)
     return out_final
}


