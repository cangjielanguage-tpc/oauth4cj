// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestAccessTokenRequestParams{
    /***
        public func addExtraParameter(name: String, value: String): AccessTokenRequestParams
        测试场景: 首次添加
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameter01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var exp_map=HashMap<String, String>([("first","first")])
        let re01=accessTokenRequestParams01.addExtraParameter("first","first")
        let re02=accessTokenRequestParams02.addExtraParameter("first","first")

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
    }
    /***
        public func addExtraParameter(name: String, value: String): AccessTokenRequestParams
        测试场景: 重复添加,与之前已存在相同
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameter02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var exp_map=HashMap<String, String>([("first","first")])

        let re01=accessTokenRequestParams01.addExtraParameter("first","first")
        let re02=accessTokenRequestParams01.addExtraParameter("first","first")
        let re03=accessTokenRequestParams02.addExtraParameter("first","first")
        let re04=accessTokenRequestParams02.addExtraParameter("first","first")

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
        @Assert(re03.getExtraParameters(),exp_map)
        @Assert(re04.getExtraParameters(),exp_map)
    }
    /***
        public func addExtraParameter(name: String, value: String): AccessTokenRequestParams
        测试场景: 重复添加,与之前已存在不同
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameter03(): Unit {
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
    /***
         public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 没有参数添加一个空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map01=HashMap<String, String>()
        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams02.addExtraParameters(map01)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
    }
    /***
        public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 没有参数添加一个非空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map01=HashMap<String, String>([("key01","value01"),("key02","value02")])

        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams02.addExtraParameters(map01)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
    }
    /***
         public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 已有参数添加一个空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters03(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var map02=HashMap<String, String>()
        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams01.addExtraParameters(map02)
        let re03=accessTokenRequestParams02.addExtraParameters(map01)
        let re04=accessTokenRequestParams02.addExtraParameters(map02)

        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
        @Assert(re03.getExtraParameters(),map01)
        @Assert(re04.getExtraParameters(),map01)
    }
    /***
         public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 已有参数添加一个非空map，且存在与已有参数重复key的map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters04(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var map02=HashMap<String, String>([("key03","value03"),("key02","value02")])
        var exp_map=HashMap<String, String>([("key01","value01"),("key02","value02"),("key03","value03")])

        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams01.addExtraParameters(map02)
        let re03=accessTokenRequestParams02.addExtraParameters(map01)
        let re04=accessTokenRequestParams02.addExtraParameters(map02)

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
        @Assert(re03.getExtraParameters(),exp_map)
        @Assert(re04.getExtraParameters(),exp_map)
    }
    /***
        public static func create(code: String): AccessTokenRequestParams
        测试场景:根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsCreate01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("")
        @Assert(accessTokenRequestParams01.getCode(),"")
        @Assert(accessTokenRequestParams02.getCode(),"")
        accessTokenRequestParams01=AccessTokenRequestParams("strValue")
        accessTokenRequestParams02=AccessTokenRequestParams.create("strValue")
        @Assert(accessTokenRequestParams01.getCode(),"strValue")
        @Assert(accessTokenRequestParams02.getCode(),"strValue")
    }
    /***
        public func getExtraParameters(): HashMap<String, String>
        测试场景: 默认构造器
    ***/
    @TestCase
    func testAccessTokenRequestParamsGetExtraParameters01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>()
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
    }
    /***
        public func getPkceCodeVerifier(): String
        测试场景: 默认构造器
    ***/
    @TestCase
    func testAccessTokenRequestParamsGetPkceCodeVerifier01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var result01 = false
        var result02 = false

        match (accessTokenRequestParams01.getPkceCodeVerifier()) {
            case Some(x) => result01 = false
            case None => result01 = true // 默认为None
        }

        match (accessTokenRequestParams02.getPkceCodeVerifier()) {
            case Some(x) => result02 = false
            case None => result02 = true // 默认为None
        }

        @Assert(result01)
        @Assert(result02)
    }
    /***
        public func GetScope(): String
        测试场景: 默认构造器
    ***/
    @TestCase
    func testAccessTokenRequestParamsGetScope01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var result01 = false
        var result02 = false

        match (accessTokenRequestParams01.getScope()) {
            case Some(x) => result01 = false
            case None => result01 = true // 默认为None
        }

        match (accessTokenRequestParams02.getScope()) {
            case Some(x) => result02 = false
            case None => result02 = true // 默认为None
        }

        @Assert(result01)
        @Assert(result02)
    }
    /***
        public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 首次设置,设置一个空的map
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetExtraParameters01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map01=HashMap<String, String>()

        let re01=accessTokenRequestParams01.setExtraParameters(map01)
        let re02=accessTokenRequestParams02.setExtraParameters(map01)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
    }
    /***
        public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 首次设置,设置非空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetExtraParameters02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map02=HashMap<String, String>([("key01","value01"),("key02","value02")])

        let re01=accessTokenRequestParams01.setExtraParameters(map02)
        let re02=accessTokenRequestParams02.setExtraParameters(map02)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map02)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map02)
        @Assert(re01.getExtraParameters(),map02)
        @Assert(re02.getExtraParameters(),map02)
    }
    /***
        public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 非首次设置,设置非空/空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetExtraParameters03(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>()
        var map02=HashMap<String, String>([("key01","value01"),("key02","value02")])

        let re01=accessTokenRequestParams01.setExtraParameters(map02)
        let re02=accessTokenRequestParams01.setExtraParameters(map01)
        let re03=accessTokenRequestParams02.setExtraParameters(map02)
        let re04=accessTokenRequestParams02.setExtraParameters(map01)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
        @Assert(re03.getExtraParameters(),map01)
        @Assert(re04.getExtraParameters(),map01)
    }
    /***
        public func getPkceCodeVerifier(): Option<String> 
		public func setPKCECodeVerifier(pkceCodeVerifier: String): AccessTokenRequestParams
        测试场景:根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetPKCECodeVerifier01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        accessTokenRequestParams01.setPKCECodeVerifier("strValue")
        accessTokenRequestParams02.setPKCECodeVerifier("strValue")
        @Assert(accessTokenRequestParams01.getPkceCodeVerifier(),"strValue")
        @Assert(accessTokenRequestParams02.getPkceCodeVerifier(),"strValue")

        accessTokenRequestParams01.setPKCECodeVerifier("")
        accessTokenRequestParams02.setPKCECodeVerifier("")
        @Assert(accessTokenRequestParams01.getPkceCodeVerifier(),"")
        @Assert(accessTokenRequestParams02.getPkceCodeVerifier(),"")
    }
    /***
        public func setScope(scope: String): AccessTokenRequestParams 
        测试场景:设置成功，根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetScope01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        accessTokenRequestParams01.setScope("strValue")
        accessTokenRequestParams02.setScope("strValue")
        @Assert(accessTokenRequestParams01.getScope(),"strValue")
        @Assert(accessTokenRequestParams02.getScope(),"strValue")
    }
    /***
        public func setScope(scope: ScopeBuilder): AccessTokenRequestParams
        测试场景:设置成功，根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetScope02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")   
        var flag=0
		try{
			accessTokenRequestParams01.setScope(ScopeBuilder())
		}catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Cannot get String from a empty ScopeBuilder")){
                 flag=1
            }
		}
		@Assert(flag,1)
		flag=0
		try{
			accessTokenRequestParams02.setScope(ScopeBuilder())
		}catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Cannot get String from a empty ScopeBuilder")){
                 flag=1
            }
		}		
		@Assert(flag,1)
    }
}