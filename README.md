phpregtest
==========

phpregtest is a simple shell script to facilitate regression testing with
[PHPUnit](http://www.phpunit.de/manual/current/en/index.html) and
[phpfarm](http://cweiske.de/tagebuch/Introducing%20phpfarm.htm).

Installation
------------

phpregtest can be obtained from github.com/olivergondza/phpregtest and
installed simply using

        # make install

Usage
-----

The most simple way to run phpregtest is just state

        $ phpregtest

from the directory you usually run phpunit command line utility.

By default phpregtest runs phpunit using all PHP interpreters installed by
phpfarm in ascending order ordered by version number. It tries to detect
phpunit and phpfarm location by itself.

phpregtest can accept the same set of arguments as phpunit does.

        $ # run 'phpunit --verbose' using all installed PHP interpreters
        $ phpregtest --verbose
        $ # Test MyClass using all installed PHP interpreters
        $ phpregtest --stop-on-failure MyClass.Test.php

Use PHP versions in descending order

        $ phpregtest -d

User can override the phpunit location using `-r` option

        $ phpregtest -r /my/path/to/phpunit/testrunner

phpfarm location can by overridden  using `-f` option

        $ phpregtest -f /my/path/to/phpfarm/main/directory

User can specify PHP version(s) to run using '-v' option

        $ # uses PHP in version 5.3.0
        $ phpregtest -v 5.3.0
        $ # uses all PHP 5 versions
        $ phpregtest -v 5*
        $ # uses versions 5.3.5 to 5.3.8 except the 5.3.7
        $ phpregtest -v 5.3.[568]

Repositories
------------

- [PHPUnit](https://github.com/sebastianbergmann/phpunit)
- [phpfarm](http://svn.php.net/viewvc/pear/ci/phpfarm/trunk/)
