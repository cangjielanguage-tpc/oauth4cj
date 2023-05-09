/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the DeviceAuthorizationJsonExtractor class.
 */
package extractors

/**
 * The class DeviceAuthorizationJsonExtractor implementation of the AbstractJsonExtractor interface.
 */
public class DeviceAuthorizationJsonExtractor <: AbstractJsonExtractor {

    protected init() {}

    /**
     * Create an DeviceAuthorizationJsonExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): DeviceAuthorizationJsonExtractor {
        return DeviceAuthorizationJsonExtractor()
    }

    /**
     * If the status code of the response is 200,
     * obtain the field information corresponding to the device authorization response from the response body,
     * encapsulate it into a DeviceAuthorization object, and return it.
     * If the status code of the response is not 200, the generateError function is called,
     * throwing an exception OAuth2AccessTokenErrorResponse.
     *
     * @Param check get messages from the response
     *
     * @Return DeviceAuthorization returns the generated DeviceAuthorization instance.
     * @throws IOException If an error occurs when obtaining the response body as a string,
     *                     an IOException will be thrown.
     */
    public func extract(response: Response): DeviceAuthorization {
        if (response.getCode() != 200) {
            generateError(response)
        }
        return createDeviceAuthorization(response.getBody())
    }

    /**
     * Retrieve the field information of the error response from the response body,
     * encapsulate it into an OAuth2AccessTokenErrorResponse exception, and throw it.
     *
     * @Param check get error message from the response
     *
     * @throws IOException If an error occurs when obtaining the response body as a string,
     *                     an IOException will be thrown.
     * @throws OAuth2AccessTokenErrorResponse
     *                     Obtain the field information of the error response from the response body,
     *                     encapsulate and throw OAuth2AccessTokenErrorResponse.
     */
    public func generateError(response: Response): Unit {
        OAuth2AccessTokenJsonExtractor.instance().generateError(response)
    }

    private func createDeviceAuthorization(rawResponse: String): DeviceAuthorization {

        let response: JsonObject = JsonValue.fromStr(rawResponse).asObject()

        let deviceAuthorization: DeviceAuthorization = DeviceAuthorization(
                extractRequiredParameter(response, "device_code", rawResponse).asString().getValue(),
                extractRequiredParameter(response, "user_code", rawResponse).asString().getValue(),
                extractRequiredParameter(response, getVerificationUriParamName(), rawResponse).asString().getValue(),
                extractRequiredParameter(response, "expires_in", rawResponse).asInt().getValue())

        var intervalSeconds: JsonValue = response
        let flagInterval: Bool = response.containsKey("interval")
        if (flagInterval) {
            intervalSeconds = response.get("interval").getOrThrow()
        }

        if (flagInterval && !intervalSeconds.toString().isEmpty()) {
            deviceAuthorization.setIntervalSeconds(Int32(intervalSeconds.asInt().getValue()))
        }

        var verificationUriComplete: String = ""
        if (response.containsKey("verification_uri_complete")) {
            verificationUriComplete = response.get("verification_uri_complete").getOrThrow().asString().getValue()
        }
        if (!verificationUriComplete.isEmpty()) {
            deviceAuthorization.setVerificationUriComplete(verificationUriComplete)
        }

        return deviceAuthorization
    }

    protected func getVerificationUriParamName(): String {
        return "verification_uri"
    }
}
