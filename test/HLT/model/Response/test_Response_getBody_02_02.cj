// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //有header,其他
    @TestCase
    func testResponseGetBody0202(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>([("Content-Encoding","gzip")]),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}