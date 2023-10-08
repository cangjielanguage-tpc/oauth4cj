// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.8.2 示例
from std import collection.*
from oauth4cj import oauth4cj.*

main() {
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put("X-Header", "X-Value")
    headers.put("Content-Disposition", "Content-Disposition-Value")
    let mp: MultipartPayload = MultipartPayload("mixed", "simple boundary", headers)
    var str: String = "This is the preamble.  It is to be ignored, though it\n" +
                      "is a handy place for composition agents to include an\n" +
                      "explanatory note to non-MIME conformant readers."
    mp.setPreamble(str)
    str = "This is implicitly typed plain US-ASCII text.\n" + "It does NOT end with a linebreak."
    var arr: Array<UInt8> = str.toUtf8Array()
    mp.addBodyPart(ByteArrayBodyPartPayload(arr))
    str = "This is explicitly typed plain US-ASCII text.\n" + "It DOES end with a linebreak.\n"
    arr = str.toUtf8Array()
    let maps: HashMap<String, String> = HashMap<String, String>()
    maps.put(OAuthConstants.CONTENT_TYPE, "text/plain; charset=us-ascii")
    let bP: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(arr, maps)
    mp.addBodyPart(bP)
    mp.setEpilogue("This is the epilogue.  It is also to be ignored.")
    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k).append(": ").append(v).append("\r\n")
    }
    str = sb.toString()
    var result: String = "X-Header: X-Value\r\n" +
                         "Content-Disposition: Content-Disposition-Value\r\n" +
                         "Content-Type: multipart/mixed; boundary=\"simple boundary\"\r\n"

	if (str!=result) {
        return 1
    }
    println(str.equals(result))

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
	if (str!=result) {
        return 2
    }
    println(str.equals(result))
    return 0
}