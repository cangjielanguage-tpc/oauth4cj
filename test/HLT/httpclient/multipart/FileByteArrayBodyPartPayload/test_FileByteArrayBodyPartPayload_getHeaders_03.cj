// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
         public func getHeaders(): HashMap<String, String>
         测试场景:返回header，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
         public init(contentType: String, payload: Array<UInt8>, name: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetHeaders03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,1)
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data")])
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re03,exp_header03)
     }
}