/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the StreamUtils class.
 */
package oauth4cj

from std import io.*
from std import collection.*
from compress import zlib.*


// Used to process streams.
public class StreamUtils  {

    private static let CHARSET: String = "UTF-8"
    private static let ENCODING_RULES: HashMap<String, String> =
                    HashMap<String, String>([("*", "%2A"), ("+", "%20"), ("%7E", "~")])
    private static let DEFAULT_NUM: Int64 = 4096

    /**
     * Returns the stream content as a UTF-8 encoded string.
     *
     * @param ins is input stream.
     * @param isGzipStream indicates whether the input stream is a GzipStream, the default is false.
     *
     * @return The return type of String, return the string encoded in UTF-8.
     * @since 0.37.2
     */
    public static func getStreamContents(ins: InputStream, isGzipStream!: Bool = false): String {
        if (!isGzipStream && ins.length <= 0) {
            throw OAuth4cjException("Cannot get String from a Null InputStream.")
        }
        let buffer: Array<Byte> = Array<Byte>(DEFAULT_NUM, item: 0)
        let out: ByteArrayStream = ByteArrayStream(DEFAULT_NUM * 5)
        try {
            var len: Int64 = 0
            while (true) {
                len = ins.read(buffer)
                if (len > 0) {
                    out.write(buffer[0..len])
                }
                if (len < DEFAULT_NUM) {
                    break
                }
            }
        } catch (e: Exception) {
            throw OAuth4cjException("read from ins failed!\n" + e.message)
        }
        if (out.length <= 0 && isGzipStream) {
            throw OAuth4cjException("Unable to obtain decompressed string from an empty InputStream.")
        }
        let res: Array<Byte> = out.readToEnd()

        out.clear()
        return String.fromUtf8(res)
    }

    /**
     * Returns the string content in the gzip stream.
     * Read and decompress the data from the InputStream stream to be decompressed,
     * and convert it to string format.
     *
     * @param ins is input stream.
     *
     * @return The return type of String, returns the string content in the gzip stream.
     * @since 0.37.2
     */
    public static func getGzipStreamContents(ins: InputStream): String {

        /*
         * GZIPInputStream:
         *    This class implements a stream filter for reading compressed data in GZIP file format.
         * GZIPInputStream.read:
         *    Decompresses bytes into the specified buffer. Returns the actual number of bytes after decompression.
         * DecompressInputStream. read (outBuf: Array<Byte>):
         *  Read and decompress data from the InputStream stream to be decompressed,
         *  and place it in the outBuf array.
         */
        let dins: DecompressInputStream = DecompressInputStream(ins, wrap: GzipFormat, bufLen: 4096)
        let res: String = getStreamContents(dins, isGzipStream: true)
        dins.close()
        return res
    }
}
