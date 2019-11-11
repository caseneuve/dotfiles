#!/bin/bash

# Path:        ~/git/lab/lex-crawler/update-db.sh
# Created:     2019-11-06, 22:04    @lenovo
# Last update: 2019-11-11, 13:30:19 @x200

DB=db.sqlite3

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GRE=$(tput setaf 10)
RED=$(tput setaf 1)

force_git=false
reset_git=false
superuser=false


print_green() { echo "${BOLD}${GRE}>>> ${1} ${NORMAL}"; }
print_red() { echo "${BOLD}${RED}>>> ${1} ${NORMAL}"; }

usage(){
    cat <<EOF
Usage: update-db.sh [-hbdrfg]

Automate database cleanup in Django. Execute in venv.

Options:
  -h   print this message
  -b   backup current database in bak/ directory (excludes -d)
  -d   delete current database
  -r   remove migrations
  -f   force git reset even when there are uncommited changes
       (works only with -g flag)
  -g   execute "git reset --hard" (use with -r) if there are not
       uncommitted changes (unless flag -f provided)

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
    while getopts "hbdfrge" option; do
        case "${option}" in
            h) usage; exit 0 ;;
            b) print_green "Making database backup"
               mkdir -p bak
               [[ -f $DB ]] && mv $DB bak/$DB$(date +"_%d%m%Y_%H%M")
               ;;
            d) [[ -f $DB ]] && print_red "Deleting current database"; rm $DB ;;
            f) force_git=true ;;
            r) print_red "Deleting migrations"
               rm */migrations/000*
               ;;
            g) reset_git=true ;;
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

check_git(){
    status=$(git status | grep "Changes not staged")
    if [[ $(git status | grep "Changes not staged") ]] && [[ $force_git != "true" ]]; then
        print_red "you have unstaged changes, stage them or provide flag -f"
        exit 1
    fi
}

reset_git(){
    check_git

    if [ $reset_git = true ]; then
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
    reset_git
    print_green "Done!"
}

main "${@}"
