/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the TimestampService interface.
 */
package services

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
