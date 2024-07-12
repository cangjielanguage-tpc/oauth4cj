/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj

/**
 * Decvice Authorization
 */
public class DeviceAuthorization {
    private var deviceCode: String = ""
    private var userCode: String = ""
    private var verificationUri: String = ""
    private var verificationUriComplete: String = ""
    private var expiresInSeconds: Int64 = 0
    private var intervalSeconds: Int32 = 5

    /**
     * Constructor
     *
     * @Param deviceCode device code
     * @Param userCode user code
     * @Param verificationUri verification uri
     * @Param expiresInSeconds validity time of the verification code
     */
    public init(deviceCode: String, userCode: String, verificationUri: String, expiresInSeconds: Int64) {
        this.deviceCode = deviceCode
        this.userCode = userCode
        this.verificationUri = verificationUri
        if (expiresInSeconds < 0) {
            throw OAuth4cjException("The validity time of the verification code cannot be negative")
        }
        this.expiresInSeconds = expiresInSeconds
    }

    /**
     * set verification uri
     *
     * @Param verificationUriComplete verification uri
     */
    public func setVerificationUriComplete(verificationUriComplete: String): Unit {
        this.verificationUriComplete = verificationUriComplete
    }

    /**
     * set the minimum amount of time in seconds that the client SHOULD wait
     * between polling requests to the token endpoint, use 5 as the default
     *
     * @Param intervalSeconds the minimum amount of time in seconds
     */
    public func setIntervalSeconds(intervalSeconds: Int32): Unit {
        if (intervalSeconds < 0) {
            throw OAuth4cjException("The time value cannot be negative")
        }
        this.intervalSeconds = intervalSeconds
    }

    /**
     * get device code
     *
     * @Return String device code
     */
    public func getDeviceCode(): String {
        return deviceCode
    }

    /**
     * get user code
     *
     * @Return String user code
     */
    public func getUserCode(): String {
        return userCode
    }

    /**
     * get verification uri
     *
     * @Return String verification uri
     */
    public func getVerificationUri(): String {
        return verificationUri
    }

    /**
     * a verification URI that includes the "user_code" or other information
     * with the same function as the "user_code"
     *
     * @Return String a verification URI that includes the "user_code"
     */
    public func getVerificationUriComplete(): String {
        return verificationUriComplete
    }

    /**
     * get validity time of the verification code
     *
     * @Return Int64 validity time of the verification code
     */
    public func getExpiresInSeconds(): Int64 {
        return expiresInSeconds
    }

    /**
     * get the minimum amount of time in seconds
     *
     * @Return Int32 the minimum amount of time in seconds
     */
    public func getIntervalSeconds(): Int32 {
        return intervalSeconds
    }

    /**
     * to String
     * 
     * @return String device authorization infomation
     */
    public func toString(): String {
        return "DeviceAuthorization{'deviceCode'='${deviceCode}'," +
               "'userCode'='${userCode}'," +
               "'verificationUri'='${verificationUri}'," +
               "'verificationUriComplete'='${verificationUriComplete}'," +
               "'expiresInSeconds'='${expiresInSeconds}'," +
               "'intervalSeconds'='${intervalSeconds}'}"
    }
}