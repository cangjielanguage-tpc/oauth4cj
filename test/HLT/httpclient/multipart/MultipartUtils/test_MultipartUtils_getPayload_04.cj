// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartUtilsB005{
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart不是ByteArrayBodyPartPayload，也不是MultipartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload04(): Unit {
        var  header=HashMap<String,String>([("key01","value01")])
        var  multipartPayload=MultipartPayload("subtype","boundary",header)
        multipartPayload.addBodyPart(BodyPartPayload())
        multipartPayload.addBodyPart(BodyPartPayload("contentType"))
        multipartPayload.addBodyPart(BodyPartPayload(HashMap<String,String>([("key01","value01")])))
        var flag=0
        try{
            MultipartUtils.getPayload(multipartPayload)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("the class type is not MultipartPayload and not ByteArrayBodyPartPayload.")){
                 flag=1
            }
        }
        @Assert(flag,1)
    }
}