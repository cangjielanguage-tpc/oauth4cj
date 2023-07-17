// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
         public func getLen(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(contentType: String, payload: Array<UInt8>, name: String, filename: String)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadgetLen03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,100)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,100)
     }
}