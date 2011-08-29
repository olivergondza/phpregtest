readonly INST_PREFIX="/inst/php-"
readonly BINARY="/bin/php"

# Default test runner
test_runner="phpunit"

# Default PHP version pattern
php_version="?.*.*"

# Default phpfarm inst dir
phpfarm_dst="/opt/phpfarm"

# Run tests in descending order
descending_order=false

# Arguments passed to the runner
runner_args=()

# Print app usage
function printUsage () {

  program=`basename $0`;

  echo "Usage: $program [OPTION]...
Run phpunit tests using php interpreters installed via phpfarm.

$program locates phpunit and phpfarm automatically.

-d              run tests in descending order
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
    (-d) descending_order=true;;
    (-f) phpfarm_dst=$2; shift;;
    (-r) test_runner=$2; shift;;
    (-v) php_version=$2; shift;;
    (-h) printUsage; exit 0;;
    (*) runner_args+=($1);;
  esac
  shift
done

sort=""
if [ $descending_order = true ]; then
  sort="sort -Vr";
else
  sort="sort -V"
fi

test_runner=$(which $test_runner)

files=$(ls $phpfarm_dst$INST_PREFIX$php_version$BINARY | $sort)

for inter in $files; do
  dir=${inter%$BINARY};
  version=${dir#$phpfarm_dst$INST_PREFIX};
  
  echo $version;
  $inter $test_runner ${runner_args[*]};
done;
