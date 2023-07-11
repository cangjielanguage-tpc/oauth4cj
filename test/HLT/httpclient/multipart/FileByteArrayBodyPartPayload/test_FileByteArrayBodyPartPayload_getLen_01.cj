// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
        public func getLen(): Int64
        测试场景:获取off，根据调用源返回
        public init(payload: Array<UInt8>)
        public init(payload: Array<UInt8>, off: Int64, len: Int64)
        public init(payload: Array<UInt8>, name: String)
    ***/
    @TestCase
    func testFileByteArrayBodyPartPayloadgetLen01(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,100)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,0)
    }
}