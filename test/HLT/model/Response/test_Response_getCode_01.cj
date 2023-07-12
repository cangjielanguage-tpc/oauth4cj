// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //init32Values等价类
    @TestCase
    func testResponseGetCode01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}

