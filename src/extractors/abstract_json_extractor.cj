/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the AbstractJsonExtractor class.
 */
package extractors

/**
 * Get the parameter value from Abstract Json Extractor.
 */
public abstract class AbstractJsonExtractor {

    protected static func extractRequiredParameter(errorNode: JsonObject, parameterName: String,
                                                    rawResponse: String): JsonValue  {
        var value: JsonValue = errorNode
        let flag: Bool = errorNode.containsKey(parameterName)
        if (flag) {
            value = errorNode.get(parameterName).getOrThrow()
        } else {
            let err: String =
                "Response body is incorrect. Can't extract a '${parameterName}' from this: '${rawResponse}'"
            throw OAuth4cjException(err)
        }

        return value
    }
}
