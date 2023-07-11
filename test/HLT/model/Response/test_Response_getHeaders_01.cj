// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestResponseB001{
    //构造器该字段为非空map.10/100个元素
    @TestCase
    func testResponseGetHeaders01(): Unit {
        var response01_10=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(10),"body")
        var response01_100=oauth4cj.model.Response(Int32(2),"message",getHashMapByLength(100),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
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
}



public func getHashMapByLength(length:Int64):HashMap<String,String>{
    var hashmap=HashMap<String,String>()
    for (i in 0..length){
        hashmap.put(i.toString(),i.toString())
    }
    return hashmap
}