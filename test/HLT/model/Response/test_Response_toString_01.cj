// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //无header
    @TestCase
    func testResponsetoString01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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

