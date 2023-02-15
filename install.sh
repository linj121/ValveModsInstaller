#!/bin/bash

USERNAME="username"
PASSWORD="password"
L4D2_CLIENT_ID="550"
CUSTOM_MAPS_PATH="./"
is_download_finished=false

read -p "Enter mod id for l4d2:" MOD_ID

if [ -n "$(find -L $CUSTOM_MAPS_PATH -regex "^.*/workshop/${MOD_ID}\.vpk$" -type f)" ]; then
    while true; do
        read -p "Mod ${MOD_ID} already exists, continue?(y/n)" continue
        case "$continue" in 
            [yY][eE][sS]|[yY] )
                break
                ;;
            [nN][oO]|[nN] )
                exit 0
                ;;
            * )
                echo -e "\nPlease answer yes or no"
                ;;
        esac
    done
fi


while [ $is_download_finished != "true" ]; do

        read -p "Enter Two-factor code:" TWO_FACTOR_CODE

        steamcmd +login $USERNAME $PASSWORD "$TWO_FACTOR_CODE" \
                 +workshop_download_item $L4D2_CLIENT_ID "$MOD_ID" validate \
                 +workshop_download_item $L4D2_CLIENT_ID "$MOD_ID" validate \
                 +quit

    while true; do
        read -p $'\nIs the download successful?(y/n)' is_successful
        case "$is_successful" in
            [yY][eE][sS]|[yY] )
                is_download_finished=true
                break
                ;;
            [nN][oO]|[nN] )
                while true; do
                    read -p 'Do you want to retry?(y/n)' retry
                    case "$retry" in
                        [yY][eE][sS]|[yY] ) 
                            break
                            ;;
                        [nN][oO]|[nN] ) 
                            exit 0
                            ;;
                        * )
                            echo "Please answer yes or no"
                            ;;
                    esac
                done
                break
                ;;
            * )
                echo "Please answer yes or no"
                ;;
        esac
    done
done

#find -L $CUSTOM_MAPS_PATH -type f -name '*_legacy.bin' -execdir bash -c 'mv -i -- "$1" "${1/legacy\.bin/legacy.vpk}"' Mover {} \;

find -L $CUSTOM_MAPS_PATH -type f -regex "^.*/[0-9]+/[0-9]+_legacy\.bin$" | sed -E "p;s|(^.*/[0-9]+)/[0-9]+_legacy\.bin$|\1.vpk|" | xargs -n2 mv 

find -L $CUSTOM_MAPS_PATH -type d -regex "^.+/[0-9]+$" | xargs -pn1 rm -r
