// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //name是/不是map的key之一
    @TestCase
    func testResponseGetHeader01(): Unit {
        var headers01=getHashMapByLength(10)
        var response01=oauth4cj.model.Response(Int32(2),"message",headers01,"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}

public func getHashMapByLength(length:Int64):HashMap<String,String>{
    var hashmap=HashMap<String,String>()
    for (i in 0..length){
        hashmap.put(i.toString(),i.toString())
    }
    return hashmap
}