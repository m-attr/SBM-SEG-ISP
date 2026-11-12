# SBM-SEG-ISP

A collaborative SBM × SEG Infocomm System Project to develop a web-based tuition and enrichment management system for student enrolment, attendance tracking and programme administration.

## Current status

The PHP project foundation is ready for development. Application features and database integration have not been implemented yet.

## Requirements

- WampServer with Apache 2.4 and PHP 8.3
- Git or GitHub Desktop
- A code editor, such as VS Code

Recommended VS Code extensions: PHP Intelephense for code assistance and PHP Debug for debugging. Debugging also requires Xdebug.

## Local setup

### 1. Clone the repository

```text
https://github.com/m-attr/SBM-SEG-ISP.git
```

The recommended local folder name is `sbm-seg-isp`.

For the standard WAMP setup, clone it into:

```text
C:\wamp64\www\sbm-seg-isp
```

### 2. Create your local configuration

Copy:

```text
config/local.example.php
```

to:

```text
config/local.php
```

The project’s base-path logic supports different local setups, including virtual hosts and differently named project folders.

A **virtual host** tells Apache which project folder to serve for a particular local address. For example, `http://isp.localhost/` can point directly to your project’s `public` folder, allowing you to keep the project somewhere outside WAMP’s `www` folder.

The **base path** tells the application which URL prefix to use when generating links, asset URLs, form actions and redirects. This provides a consistent way to handle URL paths even when developers use different project folder names or virtual hosts.

Set `base_path` to match your setup:

| Setup | Browser URL | `base_path` |
|---|---|---|
| Recommended WAMP folder | `http://localhost/sbm-seg-isp/public/` | `/sbm-seg-isp/public` |
| Differently named folder | `http://localhost/my-project/public/` | `/my-project/public` |
| Virtual host pointing to `public` | `http://isp.localhost/` | `/` |

For the recommended WAMP setup:

```php
<?php
return [
    'app' => [
        'name' => 'SBM-SEG-ISP',
        'base_path' => '/sbm-seg-isp/public',
    ],
];
```

`base_path` is a **URL prefix**, not a Windows folder path. Its value depends on the browser URL, rather than the name of every parent folder on your computer.

Your `config/local.php` is ignored by Git, so each developer can maintain their own settings. Virtual-host configuration is also specific to each computer.

See [Local development](docs/local-development.md) for virtual-host setup, debugging and troubleshooting.

## Project structure

```text
sbm-seg-isp/
├── public/
│   ├── index.php
│   └── assets/
│       ├── css/
│       ├── js/
│       └── images/
├── app/
│   ├── auth/
│   ├── attendance/
│   ├── students/
│   └── shared/
│       └── bootstrap.php
├── config/
│   ├── local.example.php
│   └── local.php
├── database/
│   ├── migrations/
│   └── seeds/
├── docs/
├── .vscode/
│   └── launch.json
├── .gitattributes
├── .gitignore
├── .htaccess
└── README.md
```

| Location | Purpose |
|---|---|
| `public/` | Files intended to be accessible through the browser. `index.php` is the current starting page. |
| `public/assets/` | Stylesheets, browser JavaScript and images. |
| `app/` | PHP application logic, organised into areas such as authentication, attendance and students. These module folders are currently placeholders. |
| `app/shared/bootstrap.php` | Loads the personal configuration and provides shared helpers for generating URLs and escaping HTML text. |
| `config/local.example.php` | Shared configuration template that developers copy when setting up the project. |
| `config/local.php` | Personal configuration, excluded from Git. |
| `database/migrations/` | Future versioned scripts describing database structure changes. Currently empty. |
| `database/seeds/` | Future scripts for inserting initial or sample data. Currently empty. |
| `docs/` | Supporting development guides. |
| `.vscode/launch.json` | Shared configuration for listening for Xdebug connections on port `9003`. |
| `.gitattributes` | Standardises text-file line endings across development environments. |
| `.gitignore` | Excludes personal configuration, dependencies and logs from Git. |
| `.htaccess` | Apache access rules. The root file protects files outside `public`; the file inside `public` disables directory listings. |

Empty folders contain `.gitkeep` placeholders so Git includes them.

## Development conventions

- Use `app_url()` when generating application URLs so they work across different local setups.
- Use `e()` when inserting plain text into HTML.
- Keep credentials and personal settings out of Git.
- Keep private application files outside `public/`.
- Pull the latest changes before starting work, and review changes before committing and pushing.

## Database and hosting

Database connectivity and deployment are not configured yet. Connection instructions and database-change rules will be documented when agreed.

Pushing application code to GitHub does not, by itself, update a hosted application or database.
