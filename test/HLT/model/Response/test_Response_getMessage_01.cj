// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    @TestCase
    func testResponseGetMessage01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}

