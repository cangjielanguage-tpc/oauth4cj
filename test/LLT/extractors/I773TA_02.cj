// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*

from oauth4cj import oauth4cj.*

main() {
    var test_01 = testHeaderExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testHeaderExtractor_01(): Int64 {
    var headerExtractorImpl01 = HeaderExtractorImpl()
    var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
    println(oauth4cjRequest.getOauthParameters().size)
    var flag = 1
    try{
        headerExtractorImpl01.extract(oauth4cjRequest)
    }catch(e:OAuth4cjParametersMissingException){
        println(e.toString())
    	println(e.message)
    	let str: String = "Could not find oauth parameters in request." +
    	                    oauth4cjRequest.toString() +
    	                    ". OAuth parameters must be specified with the addOAuthParameter() method"
        if(e.message.contains(str)){
            flag = 0
        }
    }
    return flag
}
