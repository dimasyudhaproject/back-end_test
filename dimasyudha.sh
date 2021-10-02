#!/bin/bash

logpath="/var/log/nginx"

wrong() {
    if [ $1 -eq 1 ];
        then
            clear
            echo "======================================="
            echo "|     YOU CHOSE THE WRONG NUMBER      |"
            echo "| PLEASE ONLY CHOOSE EITHER 1, 2 OR 3 |"
            echo "======================================="
            sleep 3
            clear
    elif [ $1 -eq 2 ];
        then
            clear
    fi
}

info() {
    clear
    echo "============================================="
    echo "| WELCOME TO CLI TASK FOR BACKEND DEVELOPER |"
    echo "|       SCRIPT BY DIMAS YUDHA PRATAMA       |"
    echo "============================================="
    echo " THIS IS A BASH SCRIPT FOR TESTING PURPOSE   "
    echo " YOU CAN USE THIS SCRIPT TO CONVERT FILE     "
    echo " TO EITHER '.txt' OR '.json' FORMAT          "
    echo " ALSO THIS SCRIPT IS ABLE TO STORE THE OUTPUT"
    echo " TO YOUR DESIRE PATH. USE FLAG -H FOR HELP   "
    echo "============================================="
    exit 0
}

path() {
    clear
    echo "==============================================="
    echo "| WANNA STORE THE OUTPUT TO YOUR DESIRE PATH? |"
    echo "==============================================="
    echo "| NO |    | NAME |                             "
    echo "-----------------------------------------------"
    echo "| 1. |    | YES  |                             "
    echo "| 2. |    | NO   |                             "
    echo "-----------------------------------------------"
    read -p "INSER YOUR ANSWER HERE ~> " paths
    clear

    case "$paths"
        in "1"|"2"|"3");;*)
            wrong 1
            path
    esac

    if [ "$paths" == 1 ];
        then
            read -p "INSERT YOUR DESIRE PATH ~> " pathss
            clear

            if [ "$mains" == 1 ];
                then
                    cd $logpath && mv nginxlog.txt $pathss
            elif [ "$mains" == 2 ];
                then
                    cd $logpath && mv nginxlog.json $pathss
            fi
    fi

}

convert() {
    if [ $1 -eq 1 ];
        then
            tr -sd '\0' '' < $logpath/error.log > nginxlog.txt
    elif [ $1 -eq 2 ];
        then
            awk '{print "{\"cron_stats\": { \"completion_time\": \""$1" " $2"\", \"Task\": "}' $logpath/error.log > file1.txt
            cat $logpath/error.log | cut -d']' -f3 | cut -d' ' -f2-15 | cut -d'=' -f1 > file2.txt
            cat $logpath/error.log | cut -d']' -f3 | cut -d' ' -f2-15 | cut -d'=' -f2 > file3.txt
            sed -i -e 's/[[:blank:]]*$//g' -e 's/\ /_/g' -e 's/^/"/g' -e 's/$/"/g' file2.txt
            sed -i -e 's/\ / "/g' -e 's/$/"/g' -e 's/^/, "value"\:/g' -e 's/$/} }/' file3.txt

            i=1
            END=$(wc -l file1.txt | cut -d' ' -f1)
            truncate -s 0 nginxlog.json

            for  i
                in  $(seq 1 $END);
                    do var1=$(sed -n ""$i"p" file1.txt); var2=$(sed -n ""$i"p" file2.txt); var3=$(sed -n ""$i"p" file3.txt); var4="$var1$var2$var3"; i=$(expr $i + 1); echo  $var4 | tee -a nginxlog.json;
                    done

            rm -rf file1.txt file2.txt file3.txt
            fi
}

proc() {
    clear
    if [ "$mains" == 1 ];
        then
            echo "============================================="
            echo "| THE LOG IS BEING CONVERTED TO '.txt' FILE |"
            echo "============================================="
            sleep 3
            clear
            echo "=================="
            echo "| PLEASE WAIT... |"
            echo "=================="
            sleep 5
            clear
            echo "========================================"
            echo "| THE OUTPUT IS SUCCESSFULLY CONVERTED |"
            echo "========================================"
            sleep 3
    elif [ "$mains" == 2 ];
        then
            echo "============================================="
            echo "| THE LOG IS BEING CONVERTED TO '.json' FILE |"
            echo "============================================="
            sleep 3
            clear
            echo "=================="
            echo "| PLEASE WAIT... |"
            echo "=================="
            sleep 5
            clear
            echo "========================================"
            echo "| THE OUTPUT IS SUCCESSFULLY CONVERTED |"
            echo "========================================"
            sleep 3
    fi
    clear
}

back() {
    clear
    echo "=================="
    echo "| BACK TO MAIN?  |"
    echo "=================="
    echo "| NO |    | NAME |"
    echo "------------------"
    echo "| 1. |    | YES  |"
    echo "| 2. |    | NO   |"
    echo "------------------"
    read -p "INSERT YOUR ANSWER HERE! ~> " backs
    clear

    case "$backs"
        in "1"|"2");;*)
            wrong 1
            back
    esac

    if [ "$backs" == 1 ];
        then
            main
    elif [ "$backs" == 2 ];
        then
            quit
    fi
}

quit() {
    clear
    echo "==================================="
    echo "| THANK YOU FOR USING THIS SCRIPT |"
    echo "|  SCRIPT BY DIMAS YUDHA PRATAMA  |"
    echo "==================================="
    exit
}

main() {
    clear
    echo "======================================================"
    echo "|     WELCOME TO CLI TASK FOR BACKEND DEVELOPER      |"
    echo "|           SCRIPT BY DIMAS YUDHA PRATAMA            |"
    echo "======================================================"
    echo "| NO |    | MENU NAME |   |           DESC           |"
    echo "------------------------------------------------------"
    echo "| 1. |    | PLAINTEXT |   | CONVERT TO '.TXT' FORMAT |"
    echo "| 2. |    | JSON      |   | CONVERT TO 'JSON' FORMAT |"
    echo "| 3. |    | EXIT      |   | QUIT TO USE THIS SCRIPT  |"
    echo "------------------------------------------------------"
    read -p "INSERT YOUR ANSWER HERE! ~> " mains
    clear

    case "$mains"
        in "1"|"2"|"3");;*)
            wrong 1
            main
    esac

    if [ "$mains" == 1 ];
        then
            path
            convert 1
            proc
            back
    elif [ "$mains" == 2 ];
        then
            path
            convert 2
            proc
            back
    elif [ "$mains" == 3 ];
        then
            quit
    fi
}

# RUN
while :
    do
        case "$1"
            in
                -h | --help)
                    info;;
                --)
                    wrong 2;;
                -*)
                    wrong 2;;
                *)
                    main;;
        esac
    done