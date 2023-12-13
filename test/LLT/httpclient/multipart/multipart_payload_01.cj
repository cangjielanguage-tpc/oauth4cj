// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import oauth4cj.*

main() {

    var test_01 = testMultipartPayload_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testMultipartPayload_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartPayload_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartPayload_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testMultipartPayload_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

public func testMultipartPayload_01(): Int32 {
    let mp: MultipartPayload = MultipartPayload()
    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k)
        sb.append(": ")
        sb.append(v)
        sb.append("\r\n")
    }

    var str: String = sb.toString()
    let result: String = "Content-Type: multipart/form-data; boundary=\"" + mp.getBoundary() + "\"\r\n"

    if (str != result) {
        println(1)
        return 1
    }
    
    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    if (str != "") {
        println(2)
        return 2
    }
    return 0
}

public func testMultipartPayload_02(): Int32 {
    
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put("X-Header", "X-Value")
    headers.put("Content-Disposition", "Content-Disposition-Value")
    
    let mp: MultipartPayload = MultipartPayload("mixed", "simple boundary", headers)
    var str: String = "This is the preamble.  It is to be ignored, though it\n" +
                      "is a handy place for composition agents to include an\n" +
                      "explanatory note to non-MIME conformant readers."
    mp.setPreamble(str)

    str = "This is implicitly typed plain US-ASCII text.\n" + "It does NOT end with a linebreak."
    var arr: Array<UInt8> = str.toArray()
    
    mp.addBodyPart(ByteArrayBodyPartPayload(arr))


    str = "This is explicitly typed plain US-ASCII text.\n" + "It DOES end with a linebreak.\n"
    arr = str.toArray()

    let maps: HashMap<String, String> = HashMap<String, String>()
    maps.put(OAuthConstants.CONTENT_TYPE, "text/plain; charset=us-ascii")

    let bP: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(arr, maps)
    mp.addBodyPart(bP)

    mp.setEpilogue("This is the epilogue.  It is also to be ignored.")
    

    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k)
        sb.append(": ")
        sb.append(v)
        sb.append("\r\n")
    }

    str = sb.toString()
    var result: String = "X-Header: X-Value\r\n" +
                         "Content-Disposition: Content-Disposition-Value\r\n" +
                         "Content-Type: multipart/mixed; boundary=\"simple boundary\"\r\n"
    if (str != result) {
        println(3)
        return 3
    }
    
    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    result = "This is the preamble.  It is to be ignored, though it\n" +
             "is a handy place for composition agents to include an\n" +
             "explanatory note to non-MIME conformant readers." +
             "\r\n--simple boundary\r\n" +
             "\r\n" +
             "This is implicitly typed plain US-ASCII text.\n" +
             "It does NOT end with a linebreak." +
             "\r\n--simple boundary\r\n" +
             "Content-Type: text/plain; charset=us-ascii\r\n" +
             "\r\n" +
             "This is explicitly typed plain US-ASCII text.\n" +
             "It DOES end with a linebreak.\n" +
             "\r\n--simple boundary--" +
             "\r\nThis is the epilogue.  It is also to be ignored."
    if (str != result) {
        println(4)
        return 4
    }
    return 0
}

public func testMultipartPayload_03(): Int32 {
    let mp: MultipartPayload = MultipartPayload("simple-boundary")
    mp.addBodyPart(ByteArrayBodyPartPayload("It does NOT end with a linebreak.".toArray()))
    mp.addBodyPart(ByteArrayBodyPartPayload("It does end with a \\r linebreak.\r".toArray()))
    mp.addBodyPart(ByteArrayBodyPartPayload("It does end with a \\n linebreak.\n".toArray()))
    mp.addBodyPart(ByteArrayBodyPartPayload("It does end with a \\r\\n linebreak.\r\n".toArray()))
    mp.addBodyPart(ByteArrayBodyPartPayload("the last one".toArray()))

    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k)
        sb.append(": ")
        sb.append(v)
        sb.append("\r\n")
    }

    var str: String = sb.toString()
    var result: String = "Content-Type: multipart/form-data; boundary=\"simple-boundary\"\r\n"
    if (str != result) {
        println(5)
        return 5
    }
    
    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    result = "--simple-boundary\r\n" +
             "\r\n" +
             "It does NOT end with a linebreak." +
             "\r\n--simple-boundary\r\n" +
             "\r\n" +
             "It does end with a \\r linebreak.\r" +
             "\r\n--simple-boundary\r\n" +
             "\r\n" +
             "It does end with a \\n linebreak.\n" +
             "\r\n--simple-boundary\r\n" +
             "\r\n" +
             "It does end with a \\r\\n linebreak.\r\n" +
             "\r\n--simple-boundary\r\n" +
             "\r\n" +
             "the last one" +
             "\r\n--simple-boundary--"
    if (str != result) {
        println(6)
        return 6
    }
    return 0
}

public func testMultipartPayload_04(): Int32 {
    let mp: MultipartPayload = MultipartPayload("testFileByteArrayBodyPartPayloadMultipartPayload boundary")
    mp.addBodyPart(FileByteArrayBodyPartPayload("fileContent".toArray(), "name", "filename.ext"))


    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k)
        sb.append(": ")
        sb.append(v)
        sb.append("\r\n")
    }

    var str: String = sb.toString()
    var result: String = "Content-Type: multipart/form-data; " +
                         "boundary=\"testFileByteArrayBodyPartPayloadMultipartPayload boundary\"\r\n"
    if (str != result) {
        println(7)
        return 7
    }
    
    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    result = "--testFileByteArrayBodyPartPayloadMultipartPayload boundary\r\n" +
             "Content-Disposition: form-data; name=\"name\"; filename=\"filename.ext\"\r\n" +
             "\r\n" +
             "fileContent" +
             "\r\n--testFileByteArrayBodyPartPayloadMultipartPayload boundary--"

    if (str != result) {
        println(8)
        return 8
    }
    return 0
}

public func testMultipartPayload_05(): Int32 {
    let mp: MultipartPayload = MultipartPayload("mixed", "unique-boundary-1")

    var str: String = "This is the preamble area of a multipart message.\n" +
                      "Mail readers that understand multipart format\n" +
                      "should ignore this preamble.\n" +
                      "\n" +
                      "If you are reading this text, you might want to\n" +
                      "consider changing to a mail reader that understands\n" +
                      "how to properly display multipart messages.\n"

    mp.setPreamble(str)
    mp.addBodyPart(ByteArrayBodyPartPayload("... Some text appears here ...".toArray()))

    str = "This could have been part of the previous part, but\n" +
          "illustrates explicit versus implicit typing of body\n" + "parts.\n"
    mp.addBodyPart(ByteArrayBodyPartPayload(str.toArray(), "text/plain; charset=US-ASCII"))

    let innerMP: MultipartPayload = MultipartPayload("parallel", "unique-boundary-2")
    mp.addBodyPart(innerMP)

    let audioHeaders: HashMap<String, String> = HashMap<String, String>()
    audioHeaders.put("Content-Type", "audio/basic")
    audioHeaders.put("Content-Transfer-Encoding", "base64")

    innerMP.addBodyPart(ByteArrayBodyPartPayload(("... base64-encoded 8000 Hz single-channel\n" +
                    "    mu-law-format audio data goes here ...").toArray(), audioHeaders))

    let imageHeaders: HashMap<String, String> = HashMap<String, String>()
    imageHeaders.put("Content-Type", "image/jpeg")
    imageHeaders.put("Content-Transfer-Encoding", "base64")
    innerMP.addBodyPart(
        ByteArrayBodyPartPayload("... base64-encoded image data goes here ...".toArray(), imageHeaders))

    str = "This is <bold><italic>enriched.</italic></bold>\n" +
          "<smaller>as defined in RFC 1896</smaller>\n" +
          "\n" +
          "Isn't it\n" +
          "<bigger><bigger>cool?</bigger></bigger>\n"
    mp.addBodyPart(ByteArrayBodyPartPayload(str.toArray(), "text/enriched"))

    str = "From: (mailbox in US-ASCII)\n" +
          "To: (address in US-ASCII)\n" +
          "Subject: (subject in US-ASCII)\n" +
          "Content-Type: Text/plain; charset=ISO-8859-1\n" +
          "Content-Transfer-Encoding: Quoted-printable\n" +
          "\n" +
          "... Additional text in ISO-8859-1 goes here ...\n"
    mp.addBodyPart(ByteArrayBodyPartPayload(str.toArray(), "message/rfc822"))

    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k)
        sb.append(": ")
        sb.append(v)
        sb.append("\r\n")
    }

    str = sb.toString()
    var result: String = "Content-Type: multipart/mixed; boundary=\"unique-boundary-1\"\r\n"
    if (str != result) {
        println(9)
        return 9
    }

    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    result = "This is the preamble area of a multipart message.\n" +
             "Mail readers that understand multipart format\n" +
             "should ignore this preamble.\n" +
             "\n" +
             "If you are reading this text, you might want to\n" +
             "consider changing to a mail reader that understands\n" +
             "how to properly display multipart messages.\n" +
             "\r\n--unique-boundary-1\r\n" +
             "\r\n" +
             "... Some text appears here ..." +
             "\r\n--unique-boundary-1\r\n" +
             "Content-Type: text/plain; charset=US-ASCII\r\n" +
             "\r\n" +
             "This could have been part of the previous part, but\n" +
             "illustrates explicit versus implicit typing of body\n" +
             "parts.\n" +
             "\r\n--unique-boundary-1\r\n" +
             "Content-Type: multipart/parallel; boundary=\"unique-boundary-2\"\r\n" +
             "\r\n--unique-boundary-2\r\n" +
             "Content-Type: audio/basic\r\n" +
             "Content-Transfer-Encoding: base64\r\n" +
             "\r\n" +
             "... base64-encoded 8000 Hz single-channel\n" +
             "    mu-law-format audio data goes here ..." +
             "\r\n--unique-boundary-2\r\n" +
             "Content-Type: image/jpeg\r\n" +
             "Content-Transfer-Encoding: base64\r\n" +
             "\r\n" +
             "... base64-encoded image data goes here ..." +
             "\r\n--unique-boundary-2--" +
             "\r\n--unique-boundary-1\r\n" +
             "Content-Type: text/enriched\r\n" +
             "\r\n" +
             "This is <bold><italic>enriched.</italic></bold>\n" +
             "<smaller>as defined in RFC 1896</smaller>\n" +
             "\n" +
             "Isn't it\n" +
             "<bigger><bigger>cool?</bigger></bigger>\n" +
             "\r\n--unique-boundary-1\r\n" +
             "Content-Type: message/rfc822\r\n" +
             "\r\n" +
             "From: (mailbox in US-ASCII)\n" +
             "To: (address in US-ASCII)\n" +
             "Subject: (subject in US-ASCII)\n" +
             "Content-Type: Text/plain; charset=ISO-8859-1\n" +
             "Content-Transfer-Encoding: Quoted-printable\n" +
             "\n" +
             "... Additional text in ISO-8859-1 goes here ...\n" +
             "\r\n--unique-boundary-1--"

    //println("str = ${str}")
    //println("result = ${result}")

    if (str != result) {
        println(10)
        return 10
    }
    return 0
}
