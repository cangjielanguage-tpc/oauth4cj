// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getDefaultScope(): Option<String>
        测试场景:与构造器传入一致
    ***/

    @TestCase
    func testOAuth20ServiceGetDefaultScope01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var oauth20ServiceScopeNone=OAuthServiceTest.getOAuth20ServiceScopeNone()
         var re_Scope=oauth20Service.getDefaultScope()
         var re_ScopeNone=oauth20ServiceScopeNone.getDefaultScope()
         @Assert(re_Scope,OAuthServiceTest.scope_oauth20Service.getOrThrow())
         var flag=1
         try{
             re_ScopeNone.getOrThrow()
         }catch(e:NoneValueException){
            flag=0
         }
         @Assert(flag,0)
    }
}