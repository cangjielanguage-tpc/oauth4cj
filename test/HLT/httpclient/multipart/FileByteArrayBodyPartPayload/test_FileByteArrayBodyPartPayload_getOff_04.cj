// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
         public func getOff(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(contentType: String, payload: Array<UInt8>, name: String, filename: String)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetOff03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,1)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,1)
     }
}