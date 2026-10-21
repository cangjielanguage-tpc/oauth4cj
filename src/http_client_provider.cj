/**
 * @file The file declars the HttpClientProvider interface.
 */
package oauth4cj

/**
 * Provide HttpClient based on HttpClient configuration.
 */
public interface HttpClientProvider {

    /**
     * Create HttpClient based on HttpClient configuration.
     *
     * @Param the HttpClient configuration
     *
     * @Return Option<HttpClient> Create HttpClient based on HttpClient configuration, return it.
     * @since 0.38.2
     */
    func createClient(httpClientConfig: HttpClientConfig): Option<HttpClient>
}
