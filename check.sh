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
make clean                                          # clean previous build

### 1. get dir ###
echo "Enter project number to check: "
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
make -C $DIR                                        # make

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
echo "Enter a number of test case to check"
i=0                                                 # show test case list
while [ $i -lt ${#TST[@]} ]
do
    echo "    $(($i+1)): ${TST[$i]}"
    let i=i+1
done
read TSTN                                           # get test case number
if [ $TSTN -lt 1 -o $TSTN -gt ${#TST[@]} ]          # check input error
then
    echo "ERROR: wrong test case number!"
    exit 2
fi
CHK=${TST[$(($TSTN-1))]}
cd $DIR/build
echo "########## check $CHK ##########"
pintos -v -k -T 60 -m 20 -- -q run $CHK             # run selected test case
# change flags if needed
# usage: pintos [-h] [-v] [-k] [-T TIMEOUT] [-m MEMORY]
#               [--fs-disk FS_DISK] [--swap-disk SWAP_DISK]
#               [-p HOSTFNS] [-g GUESTFNS] [--mnts MNTS] [--gdb] [-t]
echo ""
