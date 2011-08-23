# Default test runner
test_runner="phpunit"

# Default PHP version pattern
php_version="?.*.*"

# Default phpfarm inst dir
phpfarm_dst="/opt/phpfarm"

runner_args=()

while [ $# -gt 0 ]
do
  case "$1" in
    (-f) phpfarm_dst=$2; shift;;
    (-r) test_runner=$2; shift;;
    (-v) php_version=$2; shift;;
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
