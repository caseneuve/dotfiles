#!/bin/bash

# Path:        ~/git/lab/lex-crawler/update-db.sh
# Created:     2019-11-06, 22:04    @lenovo
# Last update: 2019-11-09, 20:50:31 @lenovo

DB=db.sqlite3

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GRE=$(tput setaf 10)
RED=$(tput setaf 1)

git_reset=false
superuser=false

print_green() { echo "${BOLD}${GRE}>>> ${1} ${NORMAL}"; }
print_red() { echo "${BOLD}${RED}>>> ${1} ${NORMAL}"; }

usage(){
    cat <<EOF
Usage: update-db.sh [-hbdrg]

Automate database cleanup in Django. Execute in venv.

Options:
  -h   print this message
  -b   backup current database in bak/ directory (excludes -d)
  -d   delete current database
  -r   remove migrations
  -g   execute "git reset --hard" (use with -r)

EOF
    exit 0
}

check_venv(){
    if [ -z $VIRTUAL_ENV ]; then
        alert(){ print_red "Activate virtual env first"; }

        while getopts "hbdrg" option; do
            case "${option}" in
                h) usage
                   exit 0
                   ;;
                *) alert
                   usage
                   exit 1
                   ;;
            esac
        done

        [[ -z "$1" ]] && alert; usage; exit 1
    fi
}

parse_args(){
    while getopts "hbdrge" option; do
        case "${option}" in
            h) usage; exit 0 ;;
            b) print_green "Making database backup"
               mkdir -p bak
               [[ -f $DB ]] && mv $DB bak/$DB$(date +"_%d%m%Y_%H%M")
               ;;
            d) [[ -f $DB ]] && print_red "Deleting current database"; rm $DB ;;
            r) print_red "Deleting migrations"
               rm */migrations/000*
               ;;
            g) git_reset=true ;;
            e) exit 0 ;;
        esac
    done
}

migrations(){
    print_green "$1"; python manage.py makemigrations
    print_green "$2"; python manage.py migrate
}

create_superuser(){
    if [ $superuser = true ]; then
        print_green "Creating superuser (admin)"
        echo "from django.contrib.auth.models import User; \
         User.objects.create_superuser('admin', '', 'asdf')" \
            | python manage.py shell
    fi
}

gitreset(){
    if [ $git_reset = true ]; then
        print_red "Resetting git to last commit"
        git reset --hard
        migrations "Re-making migrations" "Re-migrating"
    fi
}

main(){
    check_venv "${@}"
    parse_args "${@}"
    ! [[ -f $DB ]] && superuser=true
    migrations "Making migrations" "Migrating"
    create_superuser
    gitreset
    print_green "Done!"
}

main "${@}"
