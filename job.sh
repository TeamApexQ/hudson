if [ -z "$HOME" ]
then
  echo HOME not in environment, guessing...
  export HOME=$(awk -F: -v v="$USER" '{if ($1==v) print $6}' /etc/passwd)
fi

cd $WORKSPACE
mkdir -p ../android
cd ../android
export WORKSPACE=$PWD

rm -rf hudson
if [ ! -d hudson ]
then
  git clone git://github.com/TeamApexQ/hudson.git -b cm-11.0
fi

cd hudson
## Get rid of possible local changes
git reset --hard
git pull -s resolve

exec ./build.sh
