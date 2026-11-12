# Local development

[Back to the project README](../README.md)

This guide covers the two supported local layouts, shared URL helpers, debugging and common setup issues.

## Choose your local layout

### Option A: Project inside WAMP’s `www` folder

Recommended location:

```text
C:\wamp64\www\sbm-seg-isp
```

Browser URL:

```text
http://localhost/sbm-seg-isp/public/
```

Set this in `config/local.php`:

```php
'base_path' => '/sbm-seg-isp/public',
```

If you rename the project folder, update the URL prefix accordingly.

### Option B: Project outside `www` using a virtual host

A virtual host maps a local hostname to a folder served by Apache.

For example:

```text
http://isp.localhost/
        ↓
C:\Users\YourName\Documents\school\infocom-system-project\sbm-seg-isp\public
```

Set this in `config/local.php`:

```php
'base_path' => '/',
```

The URL has no project-folder prefix because Apache points directly to `public`.

This virtual host is already configured on the laptop used for the initial setup. Other developers only need these steps if they choose the same approach.

## Configure a virtual host

### 1. Add the Apache configuration

Back up the active Apache `httpd-vhosts.conf` file before editing it. Its location depends on the selected Apache version, for example:

```text
C:\wamp64\bin\apache\apache2.4.70\conf\extra\httpd-vhosts.conf
```

Keep the existing `localhost` entry first. For this layout, both its opening tag and the new project entry should use `<VirtualHost *:80>`.

Add the following, replacing the project path with your own:

```apache
<VirtualHost *:80>
    ServerName isp.localhost
    DocumentRoot "C:/Users/YourName/Documents/school/infocom-system-project/sbm-seg-isp/public"

    <Directory "C:/Users/YourName/Documents/school/infocom-system-project/sbm-seg-isp/public">
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require local
    </Directory>
</VirtualHost>
```

Both paths must point to the existing `public` folder. Use forward slashes in the Apache configuration.

`Require local` restricts access to this computer.

### 2. Add the local hostname

Using an editor running as administrator, open:

```text
C:\Windows\System32\drivers\etc\hosts
```

Keep existing entries and add:

```text
127.0.0.1 isp.localhost
::1       isp.localhost
```

### 3. Check and restart Apache

Run the active Apache executable with `-t` to check its configuration. For example, in PowerShell:

```powershell
& 'C:\wamp64\bin\apache\apache2.4.70\bin\httpd.exe' -t
```

After it reports `Syntax OK`, restart Apache through WAMP and visit:

```text
http://isp.localhost/
```

## Generate application URLs

The shared bootstrap loads `config/local.php` and provides `app_url()`.

Use it instead of hardcoding a developer’s project-folder name:

```php
<link rel="stylesheet"
      href="<?= e(app_url('assets/css/style.css')) ?>">

<a href="<?= e(app_url('index.php')) ?>">Home</a>

<form action="<?= e(app_url('index.php')) ?>" method="post">
    <!-- Form fields -->
</form>
```

For a PHP redirect, before sending any HTML:

```php
header('Location: ' . app_url('index.php'));
exit;
```

These examples generate the correct prefix for either local layout.

The helper does not automatically fix hardcoded URLs elsewhere. New application code should use it consistently.

## Protect private files

For virtual hosts, point Apache to `public`, rather than the repository root.

For the `www` layout, the repository’s root `.htaccess` blocks browser access to files outside `public`. Apache must allow `.htaccess` rules and have `mod_rewrite` enabled.

Configuration files, application internals and Git files should never be publicly accessible. `.gitignore` controls Git tracking; it does not prevent browser access.

## Debug with VS Code

1. Open the project folder in VS Code.
2. Install the PHP Debug extension.
3. Ensure the PHP runtime has Xdebug enabled with debug mode and port `9003`.
4. Select **Run and Debug → Listen for Xdebug**.
5. Set a breakpoint and request the page with an Xdebug trigger, for example:

```text
http://isp.localhost/?XDEBUG_TRIGGER=1
```

For the standard `www` layout:

```text
http://localhost/sbm-seg-isp/public/?XDEBUG_TRIGGER=1
```

The shared `.vscode/launch.json` listens on port `9003`. Installing the extension alone does not install or enable Xdebug.

## Common setup issues

| Issue | Check |
|---|---|
| “Local configuration is missing” | Copy `config/local.example.php` to `config/local.php`. |
| Page loads but styles or links fail | Check `base_path` against the browser URL. |
| Virtual-host address does not work | Check the hosts entry, Apache paths and configuration syntax. |
| Apache fails after a configuration edit | Run the active Apache executable with `-t` and inspect the reported error. |
| Terminal PHP differs from WAMP PHP | Check `php -v`, `php --ini` and `where.exe php`. WAMP’s PHP selection and the terminal PATH are separate settings. |
| Terminal still uses an old PATH | Close and reopen the terminal. For VS Code’s integrated terminal, fully close and reopen VS Code first. |

## Initial laptop compatibility notes

These notes record the configuration of the laptop used for the initial setup. They are included here as an audit reference and may help with troubleshooting; teammates may have different configurations.

- **Smart App Control remains enabled.**
- **PHP cURL is disabled** because its DLL was blocked. Composer works through PHP’s built-in HTTPS streams with certificate verification enabled. Downloads may be slower, and application code or packages requiring the cURL extension will need a compatible solution.
- **Apache’s optional `mod_cgi` is disabled.** Normal PHP pages use Apache’s PHP module and continue to work. Traditional CGI scripts requiring `mod_cgi` will not run.
- **Changing PHP in WAMP does not update every tool automatically.** Recheck terminal PHP, Composer’s PHP runtime and Xdebug compatibility when changing versions.

## Database and deployment

The hosted development database connection is configured. See [Database setup](database.md) to configure your personal connection and run the checker.

The development application is hosted on alwaysdata. See [Deployment](deployment.md) for automatic deployment from `main` and how to check its result.
