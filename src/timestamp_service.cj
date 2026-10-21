/**
 * @file The file declars the TimestampService interface.
 */
package oauth4cj

/**
 * timestamp generator.
 */
public interface TimestampService {

    /**
     * Returns the unix timestamp in seconds.
     *
     * @Return String timestamp
     */
    func getTimestampInSeconds(): String

    /**
     * Returns a nonce (unique value for each request).
     *
     * @return nonce
     */
    func getNonce(): String
}
