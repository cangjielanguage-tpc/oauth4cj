// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
     /***
         public func getHeaders(): HashMap<String, String>
         测试场景:返回header，根据调用源返回
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(payload: Array<UInt8>, name: String, filename: String)
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetHeaders02(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>(),1,1,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),1,200,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re03,exp_header03)
     }
}