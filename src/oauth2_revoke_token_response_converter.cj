/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package oauth4cj


/**
 * OAuth2 Revoke Token Response Converter 
 */
public class OAuth2RevokeTokenResponseConverter {
    /**
     * Create OAuth2RevokeTokenResponseConverter instance 
     */
    public init() {

    }
    /**
     * revoke token check 
     * 
     * @Param response revoke operation response information
     */
    public func convert(response: OAuth4cjResponse): Unit {
        if (response.getCode() != 200) {
            OAuth2AccessTokenJsonExtractor.instance().generateError(response)
        }
    }
}

