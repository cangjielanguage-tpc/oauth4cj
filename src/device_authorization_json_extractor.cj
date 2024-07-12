/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the DeviceAuthorizationJsonExtractor class.
 */
package oauth4cj

from std import convert.*

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
     * throwing an exception OAuth2AccessTokenErrorResponseException.
     *
     * @Param check get messages from the response
     *
     * @Return DeviceAuthorization returns the generated DeviceAuthorization instance.
     * @throws IOException If an error occurs when obtaining the response body as a string,
     *                     an IOException will be thrown.
     */
    public func extract(response: OAuth4cjResponse): DeviceAuthorization {
        if (response.getCode() != 200) {
            generateError(response)
        }
        return createDeviceAuthorization(response.getBody())
    }

    /**
     * Retrieve the field information of the error response from the response body,
     * encapsulate it into an OAuth2AccessTokenErrorResponseException exception, and throw it.
     *
     * @Param check get error message from the response
     *
     * @throws IOException If an error occurs when obtaining the response body as a string,
     *                     an IOException will be thrown.
     * @throws OAuth2AccessTokenErrorResponseException
     *                     Obtain the field information of the error response from the response body,
     *                     encapsulate and throw OAuth2AccessTokenErrorResponseException.
     */
    public func generateError(response: OAuth4cjResponse): Unit {
        OAuth2AccessTokenJsonExtractor.instance().generateError(response)
    }

    private func createDeviceAuthorization(rawResponse: String): DeviceAuthorization {

        let response: JsonObject = JsonValue.fromStr(rawResponse).asObject()

        let deviceCode: String = asStringGetValue(response, "device_code", rawResponse)
        let userCode: String = asStringGetValue(response, "user_code", rawResponse)
        let verificationUri: String = asStringGetValue(response, getVerificationUriParamName(), rawResponse)
        let expiresIn: JsonValue = extractRequiredParameter(response, "expires_in", rawResponse)
        var expiresInSeconds: Int64 = 0
        try {
            expiresInSeconds = expiresIn.asInt().getValue()
        } catch (ex: Exception) {
            expiresInSeconds = 0
        }

        let deviceAuthorization: DeviceAuthorization =
                    DeviceAuthorization(deviceCode, userCode, verificationUri, expiresInSeconds)

        if (response.containsKey("interval")) {
            let intervalJsonValue: JsonValue = response.get("interval").getOrThrow()
            deviceAuthorization.setIntervalSeconds(asIntOfJsonValue(intervalJsonValue, 5))
        }

        if (response.containsKey("verification_uri_complete")) {
            let verificationUriCompleteJsonValue: JsonValue = response.get("verification_uri_complete").getOrThrow()
            let verificationUriComplete: String = asTextOfJsonValue(verificationUriCompleteJsonValue)
            deviceAuthorization.setVerificationUriComplete(verificationUriComplete)
        }

        return deviceAuthorization
    }

    private func asStringGetValue(response: JsonObject, parameterName: String, rawResponse: String): String {
        let jsonValue: JsonValue = extractRequiredParameter(response, parameterName, rawResponse)
        var val: String = ""
        try {
            val = jsonValue.asString().getValue()
        } catch (ex: Exception) {
            val = ""
        }
        return val
    }

    protected func getVerificationUriParamName(): String {
        return "verification_uri"
    }
}

func asIntOfJsonValue(jsonValue: JsonValue, defaultNum: Int32): Int32 {
    var num: Int32 = defaultNum
    try {
        num = Int32(jsonValue.asInt().getValue())
    } catch (ex: Exception) {
        try {
            let str: String = jsonValue.asString().getValue()
            if (str.startsWith("0b") || str.startsWith("0B") || str.startsWith("0o") || str.startsWith("0O") ||
                                        str.startsWith("0x") || str.startsWith("0X")) {
                return num
            }
            num = Int32.parse(str.trimLeft("+").trimLeft("+"))
        } catch (ex: Exception) {
            num = defaultNum
        }
    }
    return num
}

func asTextOfJsonValue(jsonValue: JsonValue): String {
    var text: String = ""
    try {
        text = jsonValue.asString().getValue()
    } catch (ex: Exception) {
        try {
            text = jsonValue.asInt().getValue().toString()
        } catch (ex: Exception) {
            text = ""
        }
    }
    return text
}
