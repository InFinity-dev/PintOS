Brand new pintos for Operating Systems and Lab (CS330), KAIST, by Youngjin Kwon.

The manual is available at https://casys-kaist.github.io/pintos-kaist/

# 개발환경 세팅

```
########################## Common Part ##########################

sudo apt update

# SSH 설치
sudo apt install openssh-server

# SSH 상태 확인
sudo systemctl status ssh

# Ubuntu Firewall 정책 수정
sudo ufw allow ssh

# ip 찾기
ip a

# git 설치
sudo apt install git

# gh 설치
type -p curl >/dev/null || sudo apt install curl -y

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
| sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
https://cli.github.com/packages stable main" \
| sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

sudo apt update
sudo apt install gh

# git token Login
gh auth login
```
```
########################## Install Dependencies for PintOS ##########################
sudo apt-get install -y software-properties-common
# Add Legacy Repo for GCC
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt update && sudo apt install g++-7 -y

# Use Alternative gcc and set priority to 30 (Lower Number = Higher Priority)
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 30
# set gcc-7 to defualt gcc
sudo update-alternatives --set gcc /usr/bin/gcc-7

# Install qemu for OS emulation
sudo apt-get -y install qemu


########################## Installation Check for PintOS ##########################
cd pintos-kaist
source ./activate
cd threads
make check
# Installation Success if 20 of 27 tests comes out failed.
```
```
########################## Freeze Dependencies for PintOS ##########################
sudo apt-mark hold qemu
sudo apt-mark hold gcc
sudo apt-makr hold g++

# To Unhold
# sudo apt-mark unhold <package-name>

# To show list of holding packages
# sudo apt-mark showhold
```
```

########################## Make Script for Individual Assignment Check ##########################
cd pintos-kaist
nano

#Copy and paste following script
########################## SCRIPTS STARST HERE ##########################

#!/bin/bash

############################################################
###                                                      ###
###     0. place check.sh in pintos-kaist                ###
###                                                      ###
###     1. make check.sh executable(command below)       ###
###        $ chmod +x check.sh                           ###
###                                                      ###
###     2. run check.sh(command below)                   ###
###        $ ./check.sh                                  ###
###                                                      ###
###     3. input project number(1~4)                     ###
###                                                      ###
###     4. input test case number(depends on project)    ###
###                                                      ###
###     5. check test result!                            ###
###                                                      ###
###     project 3, 4 will be added soon                  ###
###                                                      ###
############################################################


# all projects
PRJ=( threads userprog vm filesys )

# project 1(27)
THREADS=( alarm-single \
          alarm-multiple \
          alarm-simultaneous \
          alarm-priority \
          alarm-zero \
          alarm-negative \
          priority-change \
          priority-donate-one \
          priority-donate-multiple \
          priority-donate-multiple2 \
          priority-donate-nest \
          priority-donate-sema \
          priority-donate-lower \
          priority-fifo \
          priority-preempt \
          priority-sema \
          priority-condvar \
          priority-donate-chain \
          mlfqs-load-1 \
          mlfqs-load-60 \
          mlfqs-load-avg \
          mlfqs-recent-1 \
          mlfqs-fair-2 \
          mlfqs-fair-20 \
          mlfqs-block \
          mlfqs-nice-2 \
          mlfqs-nice-10 )

# project 2(94)
USERPROG=( args-none \
           args-single \
           args-multiple \
           args-many \
           args-dbl-space \
           halt \
           exit \
           create-normal \
           create-empty \
           create-null \
           create-bad-ptr \
           create-long \
           create-exists \
           create-bound \
           open-normal \
           open-missing \
           open-boundary \
           open-empty \
           open-null \
           open-bad-ptr \
           open-twice \
           close-normal \
           close-twice \
           close-bad-fd \
           read-normal \
           read-bad-ptr \
           read-boundary \
           read-zero \
           read-stdout \
           read-bad-fd \
           write-normal \
           write-bad-ptr \
           write-boundary \
           write-zero \
           write-stdin \
           write-bad-fd \
           fork-once \
           fork-multiple \
           fork-recursive \
           fork-read \
           fork-close \
           fork-boundary \
           exec-once \
           exec-arg \
           exec-boundary \
           exec-missing \
           exec-bad-ptr \
           exec-read \
           wait-simple \
           wait-twice \
           wait-killed \
           wait-bad-pid \
           multi-recurse \
           multi-child-fd \
           rox-simple \
           rox-child \
           rox-multichild \
           bad-read \
           bad-write \
           bad-read2 \
           bad-write2 \
           bad-jump \
           bad-jump2 \
           lg-create \
           lg-full \
           lg-random \
           lg-seq-block \
           lg-seq-random \
           sm-create \
           sm-full \
           sm-random \
           sm-seq-block \
           sm-seq-random \
           syn-remove \
           syn-write \
           multi-oom \
           alarm-single \
           alarm-multiple \
           alarm-simultaneous \
           alarm-priority \
           alarm-zero \
           alarm-negative \
           priority-change \
           priority-donate-one \
           priority-donate-multiple \
           priority-donate-multiple2 \
           priority-donate-nest \
           priority-donate-sema \
           priority-donate-lower \
           priority-fifo \
           priority-preempt \
           priority-sema \
           priority-condvar \
           priority-donate-chain )

# project 3()
#VM=(  )

# project 4()
#FILESYS=(  )

### 0. init ###
echo "make clean: DO or NOT"
echo "    y(yes) : make clean"
echo "    ANY KEY : no"
read CLN
if [ "${CLN,,}" == "y" -o "${CLN,,}" == "yes" ]
then
    echo "clean previous build"
    make clean -s                                   # clean previous build
else
    echo "use previous build"                       # use previous build
fi

### 1. get dir ###
echo "Enter PROJECT NUMBER to check: "              # show project list
echo "    1: THREADS"
echo "    2: USER PROGRAMS"
echo "    3: VIRTUAL MEMORY"
echo "    4: FILE SYSTEM"
read PRJN                                           # get project number
if [ $PRJN -lt 1 -o $PRJN -gt 4 ]                   # check input error
then
    echo "ERROR: wrong project number!"
    exit 1
fi
DIR=${PRJ[$PRJN-1]}
echo "########## check directory: $DIR ##########"
make -C $DIR -s                                     # make -silent


### 2. set test ###
if [ $DIR == "threads" ]                            # project 1
then
    TST=(${THREADS[@]})
elif [ $DIR == "userprog" ]                         # project 2
then
    TST=(${USERPROG[@]})
#elif [ $DIR == "vm" ]                               # project 3
#then
#    TST=(${VM[@]})
#elif [ $DIR == "filesys" ]                          # project 4
#then
#    TST=(${FILESYS[@]})
fi
echo "Enter TEST CASE NUMBER to check"              # show test case list
i=0
echo "    $i: TEST ALL (make check)"                # 0 for test all
while [ $i -lt ${#TST[@]} ]                         # show each in loop
do
    echo "    $(($i+1)): ${TST[$i]}"
    let i=i+1
done
read TSTN                                           # get test case number
if [ $TSTN -lt 0 -o $TSTN -gt ${#TST[@]} ]          # check input error
then
    echo "ERROR: wrong test case number!"
    make clean -s                                   # clean build
    exit 2

### 3-1. make check ###
elif [ $TSTN -eq 0 ]                                # 0: test all
then
    echo "########## make check ##########"
    make -C $DIR/ check -s                          # make check -silent
    cat $DIR/build/result                           # show result
    make clean -s                                   # clean build
    exit 0
fi

### 3-2. run test case ###
CHK=${TST[$(($TSTN-1))]}
cd $DIR/build
echo "##### pintos -v -k -- -q run $CHK #####"      # run selected test case
## change flags if needed
# usage: pintos [-h] [-v] [-k] [-T TIMEOUT] [-m MEMORY]
#               [--fs-disk FS_DISK] [--swap-disk SWAP_DISK]
#               [-p HOSTFNS] [-g GUESTFNS] [--mnts MNTS] [--gdb] [-t]

# 3-2-1. project 1 ##
if [ $PRJN -eq 1 ]
then
    pintos -v -k -- -q run $CHK
fi

## 3-2-2. project 2 ##
if [ $PRJN -eq 2 ]
then
    if [ $TSTN -eq 1 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run $CHK
    elif [ $TSTN -eq 2 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run 'args-single onearg'
    elif [ $TSTN -eq 3 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run 'args-multiple some arguments for you!'
    elif [ $TSTN -eq 4 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run 'args-single onearg'
    elif [ $TSTN -eq 5 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run 'args-dbl-space two  spaces!'
    elif [ $TSTN -ge 6 -o $TSTN -le 62 ]
    then
        pintos -v -k --fs-disk=10 -p tests/userprog/$CHK:$CHK -- -q -f run $CHK
    elif [ $TSTN -ge 63 -o $TSTN -le 74 ]
    then
        pintos -v -k --fs-disk=10 -p tests/base/$CHK:$CHK -- -q -f run $CHK
    elif [ $TSTN -eq 75 ]
    then
        pintos -v -k --fs-disk=10 -p tests/no-vm/$CHK:$CHK -- -q -f run $CHK
    elif [ $TSTN -ge 76 ]
    then
        pintos -v -k --fs-disk=10 -q -thread-tests -f run $CHK
    fi
fi


### 4. fin ###
#make ../ clean -s                                   # clean build -silent


########################## SCRIPTS ENDS HERE ##########################

# CTRL + O to Write Out Script. Name it to check.sh
# CTRL + X to End nano editor

# Touch Up Permission for check.sh
chmod +x check.sh

# Enter 
# ./check.sh
# to use.

```
```
# Add Lines for PintOS in Global bashrc
cd ~
sudo nano .bashrc

########## Custom Line Add After This ##########
# PintOS
source /home/<username>/<pintos-root-folder>/activate

# CTRL + O to Write Out Script.
# CTRL + X to End nano editor
```
