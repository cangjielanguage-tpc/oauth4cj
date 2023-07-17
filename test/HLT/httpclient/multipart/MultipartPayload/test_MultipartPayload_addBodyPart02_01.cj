// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:单次添加入参MultipartPayload.getBoundary()等于本身的boundary
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0201(): Unit {
        var multipartPayload01=MultipartPayload()
        var boundary_value="boundary_value"
        var multipartPayload02=MultipartPayload(boundary_value)
        var flag=1
        try{
            multipartPayload01.addBodyPart(multipartPayload01)
        }catch(e:IllegalArgumentException){

            if(e.toString().contains("----OAuth4cj----")){
                flag=0
            }
        }
        @Assert(flag,0)

        flag=1
        try{
            multipartPayload02.addBodyPart(multipartPayload02)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("{\'boundary\'}={\'${boundary_value}\'} is the same for parent MultipartPayload and child")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}