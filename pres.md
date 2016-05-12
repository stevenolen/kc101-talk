title: Keycloak 101
author:
  name: Steve Nolen
  github: stevenolen
output: index.html
controls: true
progress: true

--

# Keycloak 101
## How I did it. And how you can do it too!

--

### What is Keycloak?

* Open Source (Red Hat funded!)
* Single Sign On/IdM/Identity Broker
* Social Broker: Google, Github, Facebook, Twitter, etc.
* Identity Broker: SAML 2.0, ldap, OIDC
* Configure 'per-realm', endless possibilities!
* Buckets of fun.

--

### Why Keycloak?

* OSS alternative to Auth0, stormpath, okta(ish?)
* Extremely loose integration needs:
  * oauth2
  * openid-connect
  * JWT
  * SAML 2.0
  * Kerberos
* One integration point, regardless of identity source (and adapters available!)
* Pluggable, themeable, easy to administrate.

--

### A quick look!

* Let's get down to business, what does it look like?
  * realms
  * clients
  * providers
  * federation

* https://auth.ohmage.org

--

### Integration Option: WAR/JBoss/Tomcat Adapter
  * role-based security embedded right in to the java web app context.

```xml
  <security-constraint>
      <web-resource-collection>
          <web-resource-name>Customers</web-resource-name>
          <url-pattern>/*</url-pattern>
      </web-resource-collection>
      <auth-constraint>
          <role-name>user</role-name>
      </auth-constraint>
  </security-constraint>
```
> "I didn't do this, because our java app uses no standards. no standards at all!" -- me

--

### Integration Option: `keycloak.js`

  * javascript library which handles authentication/redirects/refresh tokens
  * loads of helpful callbacks for listening, core maintained.

```js
  var keycloak = Keycloak();
  keycloak.init().success(function(authenticated) {
      alert(authenticated ? 'authenticated' : 'not authenticated');
  }).error(function() {
      alert('failed to initialize');
  });
```

  * Example: it practically is [this simple](https://github.com/mobilizingcs/navbar/blob/master/views/login.js#L116).

--

### Integration Option: JSON Web Tokens

  * Signable, verifiable, expirable, payloadable. 
  * Someone else can explain it better: [jwt.io](https://jwt.io/introduction/)
  * Integrates well with js lib:
    * Client: `keycloak.js` manages user's session, appends `Auth` header to server requests
    * Server: decodes token, verifies signer, ensures non-expiry, uses user info in payload
  * Example: Our ancient java server, still [gets it](https://github.com/ohmage/server/blob/master/src/org/ohmage/service/KeycloakServices.java#L56-L90).

--

### Integration Option: oauth2/openid-connect

  * So, with all that fun you'd still prefer to just use oauth2? :)
  * Standard openid-connect endpoints: `authorization`, `token`, `userinfo`, `end_session`
  * Example: A php integration for dokuwiki in a [handful of lines of code](https://github.com/stevenolen/dokuwiki-plugin-oauth)

--

### Integration Option: Keycloak Proxy

  * Now we're scraping the bottom of the barrel.
  * If you *really*, *really* can't integrate your app, you can use their security proxy.
  * Injects customizable headers and offers a URL permit/deny patterns.
  * Example: Would you even guess it? I did this to RStudio(r)!
