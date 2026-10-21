/**
 * @file The file declars the RSASha1SignatureService class.
 */
package oauth4cj


internal import stdx.crypto.keys.*
internal import stdx.crypto.digest.*

/**
 * RSA-SHA1 implementation of the SignatureService interface.
 * A signature service that uses the RSA-SHA1 algorithm.
 */
public class RSASha1SignatureService <: SignatureService {

    private static let METHOD: String = "RSA-SHA1"

    //private key file path
    private let privateKey: String

    /**
     * Create a RSASha1SignatureService instance according to the parameter.
     *
     * @param private key file path, the file must be in .pem format
     * @since 0.38.2
     */
    public init(privateKey: String) {
        this.privateKey = privateKey
    }

    /**
     * Return the signature.
     *
     * @Param the url encoding string to sign
     * @Param in the subclass RSASha1SignatureService, this parameter is not used
     * @Param in the subclass RSASha1SignatureService, this parameter is not used
     *
     * @Return String the signature
     * @throws OAuth4cjSignatureException failed to obtain signature
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        var pemPri: String = ""
        try {
            pemPri = String.fromUtf8(File.readFrom(Path(privateKey)))
        } catch (e: Exception) {
            throw OAuth4cjSignatureException("Illegal private key file!" + e.message)
        }
        try {
            let rsaPri: RSAPrivateKey = RSAPrivateKey.decodeFromPem(pemPri)
            let sha1Instance: SHA1 = SHA1()
            // let md: Array<Byte> = digest(sha1Instance, baseString)
            sha1Instance.write(baseString.toArray())
            let md: Array<Byte> = sha1Instance.finish()
            let signArray: Array<Byte> = rsaPri.sign(sha1Instance, md, padType: PKCS1)
            if (signArray.size == 0) {
                throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
            }
            return Base64Utils.encode(signArray)
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(e.message)
        }
    }

    /**
     * Return the signature method name.
     *
     * @Return String the signature method name.
     */
    public func getSignatureMethod(): String {
        return METHOD
    }
}
