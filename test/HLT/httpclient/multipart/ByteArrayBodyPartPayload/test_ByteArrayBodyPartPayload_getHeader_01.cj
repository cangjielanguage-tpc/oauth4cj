// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestByteArrayBodyPartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetPayload01(): Unit {
        var headers=HashMap<String,String>([("headers","header_value")])
        var exp_new_headers=HashMap<String,String>([("Content-Type","content-type")])
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,headers)
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(),headers)
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getHeaders(),headers)
        @Assert(bodypayload02.getHeaders(),headers)
        @Assert(bodypayload03.getHeaders(),exp_new_headers)
        @Assert(bodypayload04.getHeaders(),exp_new_headers)
        @Assert(bodypayload05.getHeaders(),HashMap<String,String>())
        @Assert(bodypayload06.getHeaders(),HashMap<String,String>())
    }
}