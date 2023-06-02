// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import builder.*

@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func addExtraParameter(name: String, value: String): AccessTokenRequestParams
        测试场景: 重复添加,与之前已存在不同
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters03(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var exp_map=HashMap<String, String>([("first","first"),("second","second")])

        let re01=accessTokenRequestParams01.addExtraParameter("first","first")
        let re02=accessTokenRequestParams01.addExtraParameter("second","second")
        let re03=accessTokenRequestParams02.addExtraParameter("first","first")
        let re04=accessTokenRequestParams02.addExtraParameter("second","second")

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
        @Assert(re03.getExtraParameters(),exp_map)
        @Assert(re04.getExtraParameters(),exp_map)
    }
}