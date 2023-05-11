/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */
package revoke

import model.Response
import extractors.OAuth2AccessTokenJsonExtractor

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
    public func convert(response: Response): Unit {
        if (response.getCode() != 200) {
            OAuth2AccessTokenJsonExtractor.instance().generateError(response)
        }
    }
}

