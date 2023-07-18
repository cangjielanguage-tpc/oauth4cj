// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //code>=200 && code <400
    @TestCase
    func testResponseIsSuccessful01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}
