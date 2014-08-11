
os_name=`uname -r`
if [[ $os_name == *ARCH* ]]
then
    os/arch/setup.sh
fi

mkdir -p ~/code
cd ~/code
git clone git@github.com:zbisch/zconfigs.git 
python ~/code/zconfigs/makeSymLinks.py > /dev/null 2> /dev/null

