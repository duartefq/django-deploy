```sh
#!/bin/bash
 _____  _                           _____             _
|  __ \(_)                         |  __ \           | |
| |  | |_  __ _ _ __   __ _  ___   | |  | | ___ _ __ | | ___  _   _
| |  | | |/ _` | '_ \ / _` |/ _ \  | |  | |/ _ \ '_ \| |/ _ \| | | |
| |__| | | (_| | | | | (_| | (_) | | |__| |  __/ |_) | | (_) | |_| |
|_____/| |\__,_|_| |_|\__, |\___/  |_____/ \___| .__/|_|\___/ \__, |
      _/ |             __/ |                   | |             __/ |
     |__/             |___/                    |_|            |___/

```
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

Automate your Django deployments.

### Server Requirements

* Python 3.4+
* Django 1.9+
* Virtualenv
* Apache 2

### Structure

```sh
releases/
	...
	app_20170125105811
	app_20170127122310
	app_20170128113401

current --symlink--> releases/app_20170128113401 # latest release
```

### Instructions

* Clone this repository in the production/test server;
* Set the directory structure of the server in the `config_base.sh` file;
* Enter the app and repository info in the `config_app.sh` file;
* Give the `deploy.sh` and `clean.sh` executable (`chmod u+x`) permission;
* Run the `deploy.sh` script to deploy
	* When running it for the first time, this script will make the initial setup;
	* Consecutive runs will deploy a release to the `releases` dir and set the last one as `current`.
* Run `clean.sh` to delete old releases.
