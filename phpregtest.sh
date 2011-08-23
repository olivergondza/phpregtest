# Default test runner
test_runner="phpunit"

# Default PHP version pattern
php_version="?.*.*"

# Default phpfarm inst dir
phpfarm_dst="/opt/phpfarm"

# Arguments passed to the runner
runner_args=()

function printUsage () {

  program=`basename $0`;

  echo "Usage: ${program} [OPTION]...
Run phpunit tests using php interpreters installed via phpfarm.

${program} locates phpunit and phpfarm automatically.

-f DIR          locates php interpreters in DIR directory.
-r FILE         use FILE test runner.
-v PATTERN      run test using php version(s) constrained by pattern.
-h              display this help and exit

PATTERN is string used by ls command. It can contain wildcards and character
classes.
  
All the other arguments are passed to the test runner.";
}

while [ $# -gt 0 ]
do
  case "$1" in
    (-f) phpfarm_dst=$2; shift;;
    (-r) test_runner=$2; shift;;
    (-v) php_version=$2; shift;;
    (-h) printUsage; exit 0;;
    (*) runner_args+=($1);;
  esac
  shift
done

test_runner=$(which ${test_runner})

files=$(ls ${phpfarm_dst}/inst/php-${php_version}/bin/php | sort -V)

for inter in $files; do
  echo ${inter};
  ${inter} ${test_runner} ${runner_args[*]};
done;
