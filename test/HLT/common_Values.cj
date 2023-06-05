// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import math.*
from oauth4cj import oauth.*
from oauth4cj import builder.*
from oauth4cj import httpclient.multipart.*
from std import io.*
from std import fs.*
from oauth4cj import exceptions.*
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
/*****    Int16等价类  ******/
public var int16Values=Array<Int16>([Int16.Max,Int16.Min,Int16.Max-1,Int16.Min+1,0])
/*****    Int8等价类  ******/
public var int8Values=Array<Int8>([Int8.Max,Int8.Min,Int8.Max-1,Int8.Min+1,0])


/*****    Bool等价类  ******/
public var boolValues=Array<Bool>([true,false])
/*****    返回固定长度字符串 ****/
public func getStringByLength(length:Int64):String{
    var str02=""
    var i=0
    while(i<10000){
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

public class SubDefaultApi20 <: DefaultApi20{
    public func getAccessTokenEndpoint():String{
         return "accessTokenEndpoint_DefaultApi20"
    }
    protected func getAuthorizationBaseUrl():String{
         return "http://www.DefaultApi20getAuthorizationBaseUrl.com"
    }
}

public class SubDefaultApi10a <: DefaultApi10a{
    public func getAccessTokenEndpoint():String{
         return "accessTokenEndpoint_DefaultApi10a"
    }
    public func getRequestTokenEndpoint():String{
         return "requestTokenEndpoint_DefaultApi10a"
    }
    protected func getAuthorizationBaseUrl():String{
         return "http://www.DefaultApi10agetAuthorizationBaseUrl.com"
    }
}
//构建MultipartUtils中getPayload预期测试结果
public func getExpByteArrayStream(multipartPayload:MultipartPayload):ByteArrayStream{
    var byteArrayStream=ByteArrayStream()
    let preamble = multipartPayload.getPreamble()
    if(!preamble.isEmpty()){
        byteArrayStream.write((preamble + "\r\n").toUtf8Array())
    }
    let bodyParts=multipartPayload.getBodyParts()
    if(bodyParts.size!=0){
        let boundary = multipartPayload.getBoundary()
        let startBoundary = ("--" + boundary + "\r\n").toUtf8Array()
        for (bodyPart in bodyParts){
            byteArrayStream.write(startBoundary)
            let bodyPartHeaders = bodyPart.getHeaders()
            var target=""
            for (header in bodyPartHeaders){
                target=header[0].toString()+": "+header[1].toString()+"\r\n"
                byteArrayStream.write(target.toUtf8Array())
            }
            byteArrayStream.write("\r\n".toUtf8Array());
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
            byteArrayStream.write("\r\n".toUtf8Array())
        }
        byteArrayStream.write(("--" + boundary + "--").toUtf8Array())
        let epilogue = multipartPayload.getEpilogue()
        if(!epilogue.isEmpty()){
            byteArrayStream.write(("\r\n" + epilogue).toUtf8Array())
        }

    }
    return byteArrayStream
}
