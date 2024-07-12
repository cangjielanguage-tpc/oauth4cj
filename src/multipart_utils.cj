/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the MultipartUtils class.
 */
package oauth4cj

from std import regex.*
from std import time.*
from std import io.*

public class MultipartUtils {

    private static let B_CHARS_NO_SPACE_PATTERN: String = "0-9a-zA-Z'()+_,-./:=?"
    private static let B_CHARS_PATTERN: String = B_CHARS_NO_SPACE_PATTERN + " "
    private static let BOUNDARY_PATTERN: String = "[" + B_CHARS_PATTERN + "]{0,69}[" + B_CHARS_NO_SPACE_PATTERN + "]"
    private static let BOUNDARY_REGEXP: Regex = Regex(BOUNDARY_PATTERN)
    private static let BOUNDARY_FROM_HEADER_REGEXP: Regex = Regex("; boundary=\"?(" + BOUNDARY_PATTERN + ")\"?")

    /**
     * Check whether the boundary has invalid syntax.
     *
     * @param boundary of String
     * @since 0.37.2
     */
    public static func checkBoundarySyntax(boundary: String): Unit {
        if (boundary.isEmpty()) {
            let err: String = "{'boundary'='" + boundary + "'} has invalid syntax. Should be '" +
                                BOUNDARY_PATTERN + "'."
            throw IllegalArgumentException(err)
        }
        let matcher: Matcher = BOUNDARY_REGEXP.matcher(boundary)
        let res: Option<MatchData> = matcher.fullMatch()

        func insideGet(): Exception {
            let err: String = "{'boundary'='" + boundary + "'} has invalid syntax. Should be '" +
                                BOUNDARY_PATTERN + "'."
            throw IllegalArgumentException(err)
        }
        res.getOrThrow(insideGet)
        return ()
    }

    /**
     * Checks the contentTypeHeader with the specified regular rules.
     * If yes, the first set of strings that match is returned, otherwise, an empty string is returned.
     *
     * @param contentTypeHeader of String, checks the string with the specified regular rules.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public static func parseBoundaryFromHeader(contentTypeHeader: String): String {
        if (contentTypeHeader.isEmpty()) {
            return ""
        }
        let matcher: Matcher = BOUNDARY_FROM_HEADER_REGEXP.matcher(contentTypeHeader)

        let res: Option<MatchData> = matcher.find()
        match (res) {
            case Some(md) => return md.matchStr(1)
            case None => return ""
        }
    }

    /**
     * return the current milliseconds string.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public static func generateDefaultBoundary(): String {
        let res: Duration = DateTime.now() - DateTime.of(year: 1970, month: Month.January, dayOfMonth: 1)
        let timeMillis: Int64 = res.toMilliseconds()
        return "----OAuth4cj----" + timeMillis.toString()
    }

    /**
     * Process the information in the MultipartPayload, encapsulate it into a ByteArrayStream, and return it。
     *
     * @param multipartPayload of MultipartPayload, process the information in the MultipartPayload.
     *
     * @return Type of ByteArrayStream
     * @since 0.37.2
     */
    public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream {
        let os: ByteArrayStream = ByteArrayStream()

        let preamble: String = multipartPayload.getPreamble()
        if (!preamble.isEmpty()) {
            os.write((preamble + "\r\n").toArray())
        }
        let bodyParts: ArrayList<BodyPartPayload> = multipartPayload.getBodyParts()
        if (!bodyParts.isEmpty()) {
            let boundary: String = multipartPayload.getBoundary()
            let startBoundary: Array<UInt8> = ("--" + boundary + "\r\n").toArray()

            for (bodyPart in bodyParts) {
                os.write(startBoundary)

                let bodyPartHeaders: HashMap<String, String> = bodyPart.getHeaders()
                if (!bodyPartHeaders.isEmpty()) {
                    for ((k, v) in bodyPartHeaders) {
                        os.write((k + ": " + v + "\r\n").toArray())
                    }
                }

                os.write("\r\n".toArray())
                if (bodyPart is MultipartPayload) {
                    getPayload((bodyPart as MultipartPayload).getOrThrow()).copyTo(os)
                } else if (bodyPart is ByteArrayBodyPartPayload) {
                    let byteArrayBodyPart: ByteArrayBodyPartPayload =
                                            (bodyPart as ByteArrayBodyPartPayload).getOrThrow()
                    var buf: Array<UInt8> = byteArrayBodyPart.getPayload()
                    buf = buf.slice(byteArrayBodyPart.getOff(), byteArrayBodyPart.getLen())
                    os.write(buf)
                } else {
                    throw OAuth4cjException("the class type is not MultipartPayload and not ByteArrayBodyPartPayload.")
                }
                os.write("\r\n".toArray()) // CRLF for the next (starting or closing) boundary.
            }

            os.write(("--" + boundary + "--").toArray())
            let epilogue: String = multipartPayload.getEpilogue()
            if (!epilogue.isEmpty()) {
                os.write(("\r\n" + epilogue).toArray())
            }
        }
        return os
    }
}
