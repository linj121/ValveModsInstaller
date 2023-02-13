#!/bin/bash

USERNAME=<steam account name>
PASSWORD=<steam password>
L4D2_CLIENT_ID=<client app id>
CUSTOM_MAPS_PATH=<path where you download your maps>
is_download_finished=false

read -p "Enter mod id for l4d2:" MOD_ID

if [ -n "$(find $CUSTOM_MAPS_PATH -regex "^.*/custom_maps/${MOD_ID}$" -type d)" ]; then
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
                echo "Please answer yes or no"
                ;;
        esac
    done
fi


while [ $is_download_finished != "true" ]; do

        read -p "Enter Two-factor code:" TWO_FACTOR_CODE

        steamcmd +login $USERNAME $PASSWORD "$TWO_FACTOR_CODE" +workshop_download_item $L4D2_CLIENT_ID "$MOD_ID" validate +quit

    while true; do
        read -p "Is the download successful?(y/n)" is_successful
        case "$is_successful" in
            [yY][eE][sS]|[yY] )
                steamcmd +quit
                is_download_finished=true
                break
                ;;
            [nN][oO]|[nN] )
                while true; do
                    read -p "Do you want to retry?(y/n)" retry
                    case "$retry" in
                        [yY][eE][sS]|[yY] ) 
                            break
                            ;;
                        [nN][oO]|[nN] ) 
                            is_download_finished=true
                            break
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

# rename bin files to vpk files
find -L $CUSTOM_MAPS_PATH -type f -name '*_legacy.bin' -execdir bash -c 'mv -i -- "$1" "${1/legacy\.bin/legacy.vpk}"' Mover {} \;

#tree -a $CUSTOM_MAPS_PATH

echo -e "\n"
