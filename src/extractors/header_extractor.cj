/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the HeaderExtractor interface.
 */
package extractors

/**
 * Generate the OAuth Authorization header to include a simple command object in the request.
 */
public interface HeaderExtractor {

    /**
     * Generate an OAuth "Authorization" HTTP header as a signature to include in the request.
     *
     * @Param check the request and generate the header
     *
     * @Return String the Http header value
     */
    func extract(request: OAuth4cjRequest): String
}
