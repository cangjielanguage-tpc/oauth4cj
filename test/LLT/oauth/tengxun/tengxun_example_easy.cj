
from std import collection.*

from oauth4cj import oauth4cj.*

main() {
    //将这些替换为在【授权服务器-腾讯】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-腾讯】添加的应用的授权，多个权限请用逗号隔开
    let SCOP: String = "get_user_info"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取access_token
            setCallback("http://www.example.com/oauth_callback/").
            build(TengxunApi.instance())

    //=== 腾讯的OAuth工作流 ===

    //调用简化模式，获取访问令牌！
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            build()
    println("授权URL: " + authorizationUrl)
}
