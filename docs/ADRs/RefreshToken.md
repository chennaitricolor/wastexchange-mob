## Refresh Token

1. To differentiate between web/mobile, clients should send custom value for user agent header like User-Agent: MyApp/0.1/iOS/10.3

2. Mobile client will start sending this header with every request.

3. **AuthTokenExpiry**: For mobile requests, identified based on User-Agent header, the authtoken would have an expiry of 14 days.

4. **RefreshTokenExpiry**: 60 days

5. On receiving 401 status for any endpoint except /refreshtoken and /login endpoints, client should refresh it's auth token by sending both the "expired auth token" and the "refresh token" to the POST /users/refresh-token endpoint and get the new pair of auth and refresh tokens for the next cycle.

6. If refresh token endpoint returns 401, log the user out.

7. Refresh token endpoint will be accessible for both mobile and web since we are not focusing on authorization right now.

