# Deployment

[Back to the project README](../README.md)

Development site: [seg-sbm-isp.alwaysdata.net](https://seg-sbm-isp.alwaysdata.net/)

## Normal workflow

1. Test your changes locally.
2. Commit and push to `main`.
3. Open the repository's **Actions** tab and check **Deploy PHP to alwaysdata**.
4. A successful run means that commit passed the server checks and the hosted version was verified.

Only `main` deploys. Other branches do not update the website. The GitHub `alwaysdata` environment also allows only the `main` branch.

The workflow can be started manually from Actions using **Run workflow** on `main`. Deployments run one at a time.

## What deployment does

- Connects to alwaysdata through a dedicated SSH key and verifies the pinned server host key.
- Fetches the repository and confirms the requested commit belongs to `main`.
- Extracts that exact commit into a new release directory.
- Links the release to the server's separate personal configuration.
- Checks PHP syntax and runs the read-only database connection checker using PHP 8.3.
- Switches the website to the checked release, then checks the HTTPS page and published commit identifier.

A failure before activation leaves the current release unchanged. If a post-activation check fails, the previous release is restored when one exists. The failed Actions run should still be investigated.

## Server layout

```text
/home/seg-sbm-isp/apps/sbm-seg-isp/
├── deploy.sh          Installed deployment command
├── repository.git/    Server-side Git cache
├── shared/local.php   Private server configuration
├── releases/          Extracted releases retained for recovery
└── current -> ...     Currently active release
```

The alwaysdata site's document root is `apps/sbm-seg-isp/current/public/`. Its PHP version follows the account's PHP 8.3 setting.

The server configuration uses `base_path => '/'` and the server's system CA bundle. It is never fetched from GitHub or overwritten by deployment.

The site uses `opcache.validate_timestamps=1`, `opcache.revalidate_freq=0`, `opcache.revalidate_path=1` and `realpath_cache_size=0` so PHP follows release-directory switches. Preserve these site settings when editing its PHP configuration.

`deployment-version.php` is generated inside each release's public folder to identify the deployed commit. It contains no credentials. The check executes PHP so that a stale PHP release cannot pass merely because static files have updated.

## Deployment access

The private deployment key is stored in GitHub's **alwaysdata environment secret** named `ALWAYSDATA_SSH_PRIVATE_KEY`. It is not a repository file. Database credentials stay on the server and in each developer's ignored local configuration; the workflow does not need them.

The matching server public key is restricted to the installed deployment command, with interactive sessions and forwarding disabled. This is a session restriction, not a separate operating-system sandbox: trusted code on `main` still runs as the hosting account.

The workflow embeds the verified SSH host public key. If alwaysdata changes it, compare the new fingerprint with the signed-in dashboard before updating the workflow; do not disable host-key checking.

## Recovery and maintenance

- To undo application changes, revert the relevant Git commit and push the resulting commit to `main`.
- A previous successful Actions run can also be rerun to redeploy its commit if that commit remains on `main`'s history.
- Prior releases are retained intentionally. Monitor the hosting quota and remove obsolete releases during maintenance, preserving the active release and anything needed for recovery.
- `scripts/deploy.sh` is the versioned source for the installed server command. Changes to that file require a maintainer to review and reinstall the server copy over SSH; normal application deployment does not replace it.
- Dependency installation and asset builds are not configured yet. Add those steps when the project introduces dependencies or a build process.

## Database changes

Deployment checks the database connection but does not run migrations, create tables, seed data or restore a database.

Record schema changes in `database/migrations/` and coordinate their application separately. Reverting application code does not reverse database changes.
