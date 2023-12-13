from std import unittest.*
from std import unittest.testmacro.*
from std import math.*
from oauth4cj import oauth4cj.*
from std import io.*
from std import fs.*
from std import collection.*
from httpclient4cj import httpclient4cj.*
from net import tls.*
from net import http.*
from std import socket.*
from std import random.*
from std import regex.*
from compress import zlib.*
from encoding import hex.*
from encoding import base64.*
from encoding import json.*
from encoding import url.*
//from crypto4cj import sha256cj.*
//from crypto4cj import sha1cj.*
//from crypto4cj import hmaccj.*
//from crypto4cj import rsacj.*
from std import sync.*
from std import time.*
from std import unicode.*
//from crypto4cj import digestcj.*

type OAuth4cjHttpClient = oauth4cj.HttpClient

/*****   字符串等价类
1. 空字符串--strEmpty
2. 固定长度(length)字符串--getStringByLength(length)
3. 多行字符串字面量--strMulti
4. 多行原始字符串字面量--strOriginMulti
5. 空白字符串--strBlank
   ****/
public var strEmpty=""
public  var strBlank=" "
public  var strMulti="""
    Hello,
    Oauth4cj"""

public  var strOriginMulti=###"
    Hello,
    Oauth4cj"###
public var strCommon="hello Cangjie"

public var strValues=Array<String>([strEmpty,getStringByLength(1000),strMulti,strOriginMulti,strBlank,strCommon])


/*****    Int64等价类  ******/
public var int64Values=Array<Int64>([Int64.Max,Int64.Min,Int64.Max-1,Int64.Min+1,0])
/*****    Int32等价类  ******/
public var int32Values=Array<Int32>([Int32.Max,Int32.Min,Int32.Max-1,Int32.Min+1,0])

/*****    Bool等价类  ******/
public var boolValues=Array<Bool>([true,false])
/*****    返回固定长度字符串 ****/
public func getStringByLength(length:Int64):String{
    var str02=""
    var i=0
    while(i<length){
        str02+=i.toString()
        i=str02.size
    }
    return str02
}

public class SubResource <: Resource{
    public var file=File("newFile.txt",OpenOption.CreateOrTruncate(true))
    public static var flagClose=false
    public init(file:File){
        this.file=file
    }
    public func close(){
        this.file.close()
        flagClose=true
    }
    public func isClosed():Bool{
        return flagClose
    }
}

public class SubDefaultApi20 <: DefaultApi20 & Equatable<SubDefaultApi20>{
    public func getAccessTokenEndpoint():String{
         return "accessTokenEndpoint_DefaultApi20"
    }
    protected func getAuthorizationBaseUrl():String{
         return "http://www.DefaultApi20getAuthorizationBaseUrl.com"
    }
    public operator func ==(that: SubDefaultApi20): Bool{
         return (this.getAccessTokenEndpoint()==that.getAccessTokenEndpoint())&&(this.getAuthorizationBaseUrl()==that.getAuthorizationBaseUrl())
    }
    public operator func !=(that: SubDefaultApi20): Bool{
         return !(this == that)
    }
}

public class SubDefaultApi10a <: DefaultApi10a & Equatable<SubDefaultApi10a>{
    public func getAccessTokenEndpoint():String{
         return "accessTokenEndpoint_DefaultApi10a"
    }
    public func getRequestTokenEndpoint():String{
         return "requestTokenEndpoint_DefaultApi10a"
    }
    protected func getAuthorizationBaseUrl():String{
         return "http://www.DefaultApi10agetAuthorizationBaseUrl.com"
    }
    public operator func ==(that: SubDefaultApi10a): Bool{
         return (this.getAccessTokenEndpoint()==that.getAccessTokenEndpoint())&&(this.getAuthorizationBaseUrl()==that.getAuthorizationBaseUrl())&&(this.getRequestTokenEndpoint()==that.getRequestTokenEndpoint())
    }
    public operator func !=(that: SubDefaultApi10a): Bool{
         return !(this == that)
    }
}
//构建MultipartUtils中getPayload预期测试结果
public func getExpByteArrayStream(multipartPayload:MultipartPayload):ByteArrayStream{
    var byteArrayStream=ByteArrayStream()
    let preamble = multipartPayload.getPreamble()
    if(!preamble.isEmpty()){
        byteArrayStream.write((preamble + "\r\n").toArray())
    }
    let bodyParts=multipartPayload.getBodyParts()
    if(bodyParts.size!=0){
        let boundary = multipartPayload.getBoundary()
        let startBoundary = ("--" + boundary + "\r\n").toArray()
        for (bodyPart in bodyParts){
            byteArrayStream.write(startBoundary)
            let bodyPartHeaders = bodyPart.getHeaders()
            var target=""
            for (header in bodyPartHeaders){
                target=header[0].toString()+": "+header[1].toString()+"\r\n"
                byteArrayStream.write(target.toArray())
            }
            byteArrayStream.write("\r\n".toArray());
            if(bodyPart is MultipartPayload){
                byteArrayStream.write(getExpByteArrayStream((bodyPart as MultipartPayload).getOrThrow()).readToEnd())
            }else if(bodyPart is ByteArrayBodyPartPayload){
                let byteArrayBodyPartPayload=(bodyPart as ByteArrayBodyPartPayload).getOrThrow()
                var buf=byteArrayBodyPartPayload.getPayload()
                buf = buf.slice(byteArrayBodyPartPayload.getOff(), byteArrayBodyPartPayload.getLen())
                byteArrayStream.write(buf)
            }else{
                throw OAuth4cjException("the class type is not MultipartPayload and not ByteArrayBodyPartPayload.")
            }
            byteArrayStream.write("\r\n".toArray())
        }
        byteArrayStream.write(("--" + boundary + "--").toArray())
        let epilogue = multipartPayload.getEpilogue()
        if(!epilogue.isEmpty()){
            byteArrayStream.write(("\r\n" + epilogue).toArray())
        }

    }
    return byteArrayStream
}
//获取HttpClientConfig
public func getOkHttpHttpClientConfig():OkHttpHttpClientConfig{
    var okhttpClientBuilder=httpclient4cj.HttpClient.builder()
    var okhttpHttpClientConfig=OkHttpHttpClientConfig(okhttpClientBuilder)
    return okhttpHttpClientConfig
}

//获取HttpClient
public func getOkHttpHttpClient():OkHttpHttpClient{
    var okhttpHttpClientConfig=getOkHttpHttpClientConfig()
    var okhttpHttpClient=OkHttpHttpClient(okhttpHttpClientConfig)
    return okhttpHttpClient
}
//判等TlsClientVerifyMode(CertificateVerifyMode)
public func assertTlsClientVerifyMode(thisTlsmode:CertificateVerifyMode,thatTlsmode:CertificateVerifyMode):Bool{
     let firstTlsmode=match(thisTlsmode){
        case CertificateVerifyMode.Default => "Default"
        case CertificateVerifyMode.TrustAll =>  "TrustAll"
        case _ => "CustomCA"
    }
    let secondTlsmode=match(thatTlsmode){
        case CertificateVerifyMode.Default =>  "Default"
        case CertificateVerifyMode.TrustAll =>  "TrustAll"
        case _ => "CustomCA"
    }
    return firstTlsmode==secondTlsmode
}

public class OAuthServiceTest{
    public static let  api_oauth10aService=SubDefaultApi10a()
    public static let  api_oauth20Service=SubDefaultApi20()
    public static let  apiKey=" apiKey"
    public static let  apiSecret=" apiSecret"
    public static let  callback=" callback"
    public static let  userAgent=" userAgent"
    public static let  scope_oauth10aService=Option<String>.Some("OAuth10aService scope")
    public static let  scope_oauth10aService_None=Option<String>.None
    public static let  scope_oauth20Service=Option<String>.Some("OAuth20Service scope")
    public static let  scope_oauth20Service_None=Option<String>.None
    public static let  responseType="responseType"
    public static var  byteArrayStream_oauth10aService=ByteArrayStream()
    public static var  byteArrayStream_oauth20Service=ByteArrayStream()
    public static let  httpClientConfig_oauth10aService=Option<HttpClientConfig>.Some(getOkHttpHttpClientConfig())
    public static let  httpClientConfig_oauth10aService_None=Option<HttpClientConfig>.None
    public static let  httpClient_oauth10aService=Option<OAuth4cjHttpClient>.Some(getOkHttpHttpClient())
    public static let  httpClient_oauth10aService_None=Option<OAuth4cjHttpClient>.None
    public static let  httpClientProvider_oauth10aService=Option<HttpClientProvider>.Some(OkHttpProvider())
    public static let  httpClientProvider_oauth10aService_None=Option<HttpClientProvider>.None
    public static let  httpClientConfig_oauth20Service=Option<HttpClientConfig>.Some(getOkHttpHttpClientConfig())
    public static let  httpClientConfig_oauth20Service_None=Option<HttpClientConfig>.None
    public static let  httpClient_oauth20Service=Option<OAuth4cjHttpClient>.Some(getOkHttpHttpClient())
    public static let  httpClient_oauth20Service_None=Option<OAuth4cjHttpClient>.None
    public static let  httpClientProvider_oauth20Service=Option<HttpClientProvider>.Some(OkHttpProvider())
    public static let  httpClientProvider_oauth20Service_None=Option<HttpClientProvider>.None

    public static func getOAuth10aService():OAuth10aService{
        return  OAuth10aService(api_oauth10aService,
                                             "OAuth10aService"+apiKey,
                                             "OAuth10aService"+apiSecret,
                                             "OAuth10aService"+callback,
                                             scope_oauth10aService,
                                             Option<OutputStream>.Some(byteArrayStream_oauth10aService),
                                             "OAuth10aService"+userAgent,
                                             httpClientConfig_oauth10aService,
                                             httpClient_oauth10aService,
                                             httpClientProvider_oauth10aService)
    }
    public static func getOAuth10aServiceScopeNone():OAuth10aService{
        return  OAuth10aService(api_oauth10aService,
                                             "OAuth10aService"+apiKey,
                                             "OAuth10aService"+apiSecret,
                                             "OAuth10aService"+callback,
                                             scope_oauth10aService_None,
                                             Option<OutputStream>.Some(byteArrayStream_oauth10aService),
                                             "OAuth10aService"+userAgent,
                                             httpClientConfig_oauth10aService,
                                             httpClient_oauth10aService,
                                             httpClientProvider_oauth10aService)
    }
    public static func getOAuth10aServiceHttpClientConfigNone():OAuth10aService{
        return  OAuth10aService(api_oauth10aService,
                                             "OAuth10aService"+apiKey,
                                             "OAuth10aService"+apiSecret,
                                             "OAuth10aService"+callback,
                                             scope_oauth10aService,
                                             Option<OutputStream>.Some(byteArrayStream_oauth10aService),
                                             "OAuth10aService"+userAgent,
                                             httpClientConfig_oauth10aService_None,
                                             httpClient_oauth10aService,
                                             httpClientProvider_oauth10aService)
    }
    public static func getOAuth10aServiceHttpClientNone():OAuth10aService{
        return  OAuth10aService(api_oauth10aService,
                                             "OAuth10aService"+apiKey,
                                             "OAuth10aService"+apiSecret,
                                             "OAuth10aService"+callback,
                                             scope_oauth10aService,
                                             Option<OutputStream>.Some(byteArrayStream_oauth10aService),
                                             "OAuth10aService"+userAgent,
                                             httpClientConfig_oauth10aService,
                                             httpClient_oauth20Service_None,
                                             httpClientProvider_oauth10aService)
    }
    public static func getOAuth10aServicehttpClientProviderNone():OAuth10aService{
        return  OAuth10aService(api_oauth10aService,
                                             "OAuth10aService"+apiKey,
                                             "OAuth10aService"+apiSecret,
                                             "OAuth10aService"+callback,
                                             scope_oauth10aService,
                                             Option<OutputStream>.Some(byteArrayStream_oauth10aService),
                                             "OAuth10aService"+userAgent,
                                             httpClientConfig_oauth10aService,
                                             httpClient_oauth10aService,
                                             httpClientProvider_oauth10aService_None)
    }

    public static func getOAuth20Service():OAuth20Service{
        return  OAuth20Service(api_oauth20Service,
                                             "OAuth20Service"+apiKey,
                                             "OAuth20Service"+apiSecret,
                                             "OAuth20Service"+callback,
                                             scope_oauth20Service,
                                             responseType,
                                             Option<OutputStream>.Some(byteArrayStream_oauth20Service),
                                             "OAuth20Service"+userAgent,
                                             httpClientConfig_oauth20Service,
                                             httpClient_oauth20Service,
                                             httpClientProvider_oauth20Service)
    }
    public static func getOAuth20ServiceScopeNone():OAuth20Service{
        return  OAuth20Service(api_oauth20Service,
                                             "OAuth20Service"+apiKey,
                                             "OAuth20Service"+apiSecret,
                                             "OAuth20Service"+callback,
                                             scope_oauth20Service_None,
                                             responseType,
                                             Option<OutputStream>.Some(byteArrayStream_oauth20Service),
                                             "OAuth20Service"+userAgent,
                                             httpClientConfig_oauth20Service,
                                             httpClient_oauth20Service,
                                             httpClientProvider_oauth20Service)
    }
    public static func getOAuth20ServiceHttpClientConfigNone():OAuth20Service{
        return  OAuth20Service(api_oauth20Service,
                                             "OAuth20Service"+apiKey,
                                             "OAuth20Service"+apiSecret,
                                             "OAuth20Service"+callback,
                                             scope_oauth20Service,
                                             responseType,
                                             Option<OutputStream>.Some(byteArrayStream_oauth20Service),
                                             "OAuth20Service"+userAgent,
                                             httpClientConfig_oauth20Service_None,
                                             httpClient_oauth20Service,
                                             httpClientProvider_oauth20Service)
    }
    public static func getOAuth20ServiceHttpClientNone():OAuth20Service{
        return  OAuth20Service(api_oauth20Service,
                                             "OAuth20Service"+apiKey,
                                             "OAuth20Service"+apiSecret,
                                             "OAuth20Service"+callback,
                                             scope_oauth20Service,
                                             responseType,
                                             Option<OutputStream>.Some(byteArrayStream_oauth20Service),
                                             "OAuth20Service"+userAgent,
                                             httpClientConfig_oauth20Service,
                                             httpClient_oauth20Service_None,
                                             httpClientProvider_oauth20Service)
    }
    public static func getOAuth20ServicehttpClientProviderNone():OAuth20Service{
        return  OAuth20Service(api_oauth20Service,
                                             "OAuth20Service"+apiKey,
                                             "OAuth20Service"+apiSecret,
                                             "OAuth20Service"+callback,
                                             scope_oauth20Service,
                                             responseType,
                                             Option<OutputStream>.Some(byteArrayStream_oauth20Service),
                                             "OAuth20Service"+userAgent,
                                             httpClientConfig_oauth20Service,
                                             httpClient_oauth20Service,
                                             httpClientProvider_oauth20Service_None)
    }
    
}

public class SubOAuthAsyncRequestCallback <:OAuthAsyncRequestCallback{
    public static var flag_onCompleted="fail"
    public static var flag_onThrowable="fail"
    public func onCompleted(response: Any): Unit{
        flag_onCompleted="pass"
        (response as oauth4cj.OAuth4cjResponse)
    }
    public func onThrowable(e: Exception): Unit{
        flag_onThrowable="pass"
        print(e.toString())
    }
    public func getFlagOnCompleted():String{
        return  (flag_onCompleted  as String).getOrThrow()
    }
    public func getFlagOnThrowable():String{
        return  (flag_onThrowable  as String).getOrThrow()
    }
}
public var port:UInt16=0
public func serve10a(){
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()
    server.distributor.register("/1234", { httpContext =>
        sleep(1*Duration.second)
        var returnJson: String = "error"
        let header = httpContext.request.headers
        //let authorizationSub = header.get("Authorization").getOrThrow()[0].substring(6)
        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]

        let splitArray: Array<String> = authorizationSub.split(",")
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }
        var isGetRequestToken = splitMap.contains("oauth_consumer_key")
        var isGetAccressToken = splitMap.contains("oauth_token")
        if (isGetRequestToken && isGetAccressToken) {
            returnJson = ##"{"oauth_token":"access_token","oauth_token_secret":"access_token_secret"}"##

        } else if (isGetRequestToken) {
            returnJson = ##"{"oauth_token":"request_token_0","oauth_token_secret":"request_token_secret_0"}"##

        } else {
            returnJson = "error"
        }
        if (isGetAccressToken) {
            let token: String = splitMap.get("oauth_token").getOrThrow()
            if (token == "\"access_token\"") {
                returnJson = ##"{"key1":"value1","key2":"value2"}"##
            }
        }
        let resp = returnJson.toArray()
        httpContext.responseBuilder.body(resp)
        return
    })
    spawn{ 
        server.serve() 
    }
    sleep(Duration.second)
    port = serverSocket.localAddress.port
}

public func serve20(){
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()
    server.distributor.register("/1234", { httpContext =>
        sleep(1*Duration.second)
        var returnJson: String = "error"
        let header = httpContext.request.headers
        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]
        let splitArray: Array<String> = authorizationSub.split(",")
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }
        var isGetRequestToken = splitMap.contains("oauth_consumer_key")
        var isGetAccressToken = splitMap.contains("oauth_token")
        if (isGetRequestToken && isGetAccressToken) {
            returnJson = ##"{"oauth_token":"access_token","oauth_token_secret":"access_token_secret"}"##

        } else if (isGetRequestToken) {
            returnJson = ##"{"oauth_token":"request_token_0","oauth_token_secret":"request_token_secret_0"}"##

        } else {
            returnJson = "error"
        }
        if (isGetAccressToken) {
            let token: String = splitMap.get("oauth_token").getOrThrow()
            if (token == "\"access_token\"") {
                returnJson = ##"{"key1":"value1","key2":"value2"}"##
            }
        }
        let resp = returnJson.toArray()
        httpContext.responseBuilder.body(resp)
        return
    })
    spawn{ 
        server.serve() 
    }
    sleep(Duration.second)
    port = serverSocket.localAddress.port
}


class MyInterceptor <: Interceptor {
    var client: Option<httpclient4cj.HttpClient> = Option<httpclient4cj.HttpClient>.None
    public func setClient(client: httpclient4cj.HttpClient) {
        this.client = client
    }

    public func intercept(chain: Chain): httpclient4cj.Response {
        let dispatcher = client.getOrThrow().getDispatcher()
        dispatcher.runningCalls()//let run = dispatcher.runningCalls()
        let request: httpclient4cj.Request = chain.getRequest()
        let requestBuilder: httpclient4cj.RequestBuilder  = request.newBuilder()
        //let header: Header = request.getHeaders()
        var response: httpclient4cj.Response =  chain.proceed(requestBuilder.build())
        let responseBuilder: httpclient4cj.ResponseBuilder = response.newBuilder().request(request)
        return responseBuilder.build()
    }
}


public class MyApi20 <: DefaultApi20 {
    protected init() {}
    public static func instance(): MyApi20 {
        return MyApi20()
    }
    public func getRequestTokenEndpoint(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    public func getAccessTokenEndpoint(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    protected func getAuthorizationBaseUrl(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenJSONExtractor.instance()
    }
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }
}
public class MyApi10a <: DefaultApi10a {
    protected init() {}
    public static func instance(): MyApi10a {
        return MyApi10a()
    }
    public func getRequestTokenEndpoint(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    public func getAccessTokenEndpoint(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    protected func getAuthorizationBaseUrl(): String {
        return "http://127.0.0.1:${port}/1234"
    }
    public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenJSONExtractor.instance()
    }
    public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken> {
        return OAuth1AccessTokenJSONExtractor.instance()
    }
}

public class GiteeApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApi {
        return GiteeApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://gitee.com/oauth/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://gitee.com/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return getAccessTokenEndpoint()
    }

    //返回指定的, RFC 7009 OAuth 2.0 令牌撤销链接
    public func getRevokeTokenEndpoint(): String {
        return getAccessTokenEndpoint()
    }
}
public class HuaweiApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): HuaweiApi {
        return HuaweiApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return getAccessTokenEndpoint()
    }

    //返回指定的, RFC 7009 OAuth 2.0 令牌撤销链接
    public func getRevokeTokenEndpoint(): String {
        return getAccessTokenEndpoint()
    }
}
public func getDeviceBaseUrl(userCode: String): String {
    return "https://oauth-login1.cloud.huawei.com/oauth2/v3/device?user_code=${userCode}&lang=zh-cn"
}
public class SubResponseConverter<: ResponseConverter{
     public var flag=0
     public func getflag():Int64{
         return flag
     }
     public func convert(response: oauth4cj.OAuth4cjResponse): OAuth2AccessToken {
         let accessToken: OAuth2AccessToken = OAuth2AccessToken("123")
         response.close()
         flag+=5
         return accessToken
     }

}

public class WeiboApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): WeiboApi {
        return WeiboApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://api.weibo.com/oauth2/access_token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://api.weibo.com/oauth2/authorize"
    }

    //返回指定的, RFC 7009 OAuth 2.0 令牌撤销链接
    public func getRevokeTokenEndpoint(): String {
        return "https://api.weibo.com/oauth2/revokeoauth2"
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
public class GithubApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GithubApi {
        return GithubApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://github.com/login/oauth/access_token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://github.com/login/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的自定义实现。
    //适合解析的数据类型：access_token=${access_token}&scope=${scope}&token_type=${token_type}
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return "https://github.com/login/device/code"
    }

}
