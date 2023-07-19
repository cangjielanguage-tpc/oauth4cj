// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init(boundary: String, headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，且key包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0404(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("Content-Type","; boundary=\"?(1adsaffecz)\"")])
        var flag=0
        try{
            var multipartPayload04=MultipartPayload("boundary",map01)
            println(multipartPayload04.getEpilogue())
        }catch(e:IllegalArgumentException){

            if(e.toString().contains("Different boundaries was passed in constructors. One as argument, second as header")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
}