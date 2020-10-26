#! /bin/bash -e

echo "Install script for Lysmarine :)"

## Check variable declaration
if [[ -z $LMARCH ]];then
  export LMARCH="$(dpkg --print-architecture)"
fi
echo "Architecture : $LMARCH"

if [[ -z $LMOS ]]; then
  if [ ! -f /usr/bin/lsb_release ]; then
    apt-get install -y -q lsb-release
  fi
  export LMOS="$(lsb_release -id -s | head -1)"
fi
echo "Base OS : $LMOS"

## This makes less noise in cross-build environment.
export LANG="en_US.UTF-8"
export LANGUAGE=en_US:en
export LC_NUMERIC="C"
export LC_CTYPE="C"
export LC_MESSAGES="C"
export LC_ALL="C"

## If no build stage provided, build all stages.
if [ "$#" -gt "0" ]; then
	argumentList="$@"
else
	argumentList="*.*"
fi

set -f
for argument in $argumentList; do # access each element of array
	stage=$(echo $argument | cut -d '.' -f 1)
	script=$(echo $argument | cut -s -d '.' -f 2)

	if [ ! $script ]; then
		script="*"
	fi

	set +f
	for scriptLocation in ./$stage*/$script*.sh; do
      if [ -f $scriptLocation ]; then
        echo ''
        echo '=========================================='
        echo "From request $argument "
        echo "Running stage $stage -> $script ( $scriptLocation )"
        echo '=========================================='
        echo ''
        export FILE_FOLDER=${scriptLocation%/*}/files/
        $scriptLocation 2>&1 | tee "logs/$stage.$script.log"
        [[ ${PIPESTATUS[0]} -ne 0 ]] && exit
      fi
  done
done

echo "Done Installing script for Lysmarine $ARCH :)"

