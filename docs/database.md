# Database setup

[Back to the project README](../README.md)

The project uses an alwaysdata-hosted MariaDB development database. Its initial connection has been verified; no application tables or sample data have been created yet.

Local WAMP applications can connect to this shared database over the internet. The hosted PHP application uses its own private server configuration for the same development database. See [Deployment](deployment.md) for how the hosted code is updated.

## Personal configuration

Keep database settings in the Git-ignored `config/local.php`. Add the `database` section from `config/local.example.php` to your existing configuration, preserving your own `app.base_path`.

```php
'database' => [
    'host' => 'mysql-ACCOUNT.alwaysdata.net',
    'port' => 3306,
    'name' => 'ACCOUNT_dev',
    'username' => 'ACCOUNT_devapp',
    'password' => 'YOUR_DATABASE_PASSWORD',
    'ssl_ca' => 'C:/path/to/cacert.pem',
],
```

Obtain the actual hostname, database name, username and password privately from the project maintainer. The alwaysdata dashboard lists the service under **Databases → MySQL**, although its database engine is MariaDB.

Never commit real credentials. In PHP single-quoted values, escape a literal backslash as `\\` and a literal apostrophe as `\'`.

## Secure connections

The development database user requires SSL/TLS and has rights only on the development database. It currently has all rights on that database, including changing or deleting its tables; this is not a production permission model.

The shared connection helper verifies the database server's certificate using the CA bundle specified by `ssl_ca` and checks that the connection is encrypted. Do not disable certificate verification to work around a connection failure.

On Windows, download the public Mozilla CA bundle from [curl's official HTTPS endpoint](https://curl.se/ca/cacert.pem), keep it outside the repository, and set `ssl_ca` to its absolute path. For example:

```text
C:/wamp64/certs/isp-cacert.pem
```

The bundle must be readable by both terminal PHP and the Apache service. The initial laptop uses the WAMP certificate directory above because its web process could not read the first copy under AppData.

Keep this CA bundle current. It contains public trust certificates, not the database password. A hosted Linux environment can use its maintained system CA bundle; the correct server-side path must be verified when deploying.

## Check the connection

From the repository root:

```powershell
php scripts/check-db.php
```

The command checks connectivity with `SELECT 1`, reports the database server and TLS versions, and counts tables/views in the configured database. It does not create tables or modify application data.

The checker runs from the command line only. No public database-check page is included.

If it fails, check the credentials, internet connection, database hostname/port, any database-user IP restriction, and the CA bundle path. Use the database user's password, not the alwaysdata account-login password.

## Use the connection in PHP

After loading the shared bootstrap:

```php
require_once dirname(__DIR__) . '/app/shared/bootstrap.php';
require_once dirname(__DIR__) . '/app/shared/database.php';

$pdo = database_connection($config['database'] ?? []);
```

This example assumes a PHP entry point directly inside `public/`. Adjust filesystem paths when using another location.

The connection is opened only when requested. The starter page can still run without database credentials. Use prepared statements for queries involving user input, and handle connection failures with a generic user-facing error rather than displaying credentials or raw database errors.

## Shared development rules

- Treat the current database as development-only and use sample data.
- Changes made through any connected local application affect the shared database immediately.
- Coordinate table changes with the team and record agreed SQL changes under `database/migrations/`; no migration runner exists yet.
- Keep seed scripts under `database/seeds/` when sample data is introduced.
- Use a separate database for production before introducing real users or live data.
- Pulling or pushing Git commits does not apply database changes automatically.

## References

- [alwaysdata MariaDB/MySQL documentation](https://help.alwaysdata.com/en/docs/web-hosting/databases/mariadb/)
- [PHP PDO MySQL documentation](https://www.php.net/manual/en/ref.pdo-mysql.php)
