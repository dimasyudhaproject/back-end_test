#!/bin/bash

info() {
    echo "============================================="
    echo "| WELCOME TO CLI TASK FOR BACKEND DEVELOPER |"
    echo "|       SCRIPT BY DIMAS YUDHA PRATAMA       |"
    echo "============================================="
    echo "|NO|  |       FLAGS       |     DESC         "
    echo "---------------------------------------------"
    echo "|1 |  |-p or --plain-text |                  "
    echo "|2 |  |-j or --json       |                  "
    echo "|3 |  |-o or --output     |                  "
    echo "|4 |  |-h or --help       |                  "
    echo "---------------------------------------------"
    exit 0
}

proc() {
    echo "============================================"
    echo "| THE LOG IS BEING CONVERTED TO UND FORMAT |"
    echo "============================================"
    sleep 3
    clear
    echo "=================================================="
    echo "| THE LOG IS SUCCESFULLY CONVERTED TO UND FORMAT |"
    echo "=================================================="
    sleep 3
    clear
    echo "================================"
    echo "| THANKS FOR USING THIS SCRIPT |"
    echo "================================"
    sleep 3
    clear
    exit 0
}

wrong() {
    echo "======"
    echo " WRONG"
    echo "======"
    exit 0
}

#ARGS=`getopt -o "o::" -l "output:" -- "$@"`
#eval set -- "$ARGS"
declare -A _output;
_output['flag']=0;
_output['path']=0;

while :
    do
        case "$1"
            in
                -t | --text)
                    if [ "$1" == 'text' ];
                        then
                            -t text
                    elif [ "$1" == 'json' ];
                        then
                            -t json
                    fi
                    proc;;
                -o | --output)
                    _output['flag']=1;
                    _output['path']=$2;
                    proc;;
                -h | --help)
                    info;;
                --)
                    wrong;;
                -*)
                    wrong;;
                 *)
                     > error.txt
                     proc;;
    esac
done