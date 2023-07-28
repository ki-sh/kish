#!/usr/bin/env bash
source "$HOME/.kish/lib/util.sh"
source "$HOME/.kish/lib/log.sh"

# gives datespec if lastparam
# @param array (not string)
function get_date_param() {

    local lastparam="${@: -1}"
    local dateparam

    if [[ $lastparam =~ .*[0-9].* ]]; then
        log_info "$s matches $regex"
        dateparam=$lastparam
    fi
    # log_info "lastparam: $lastparam get_date_param: $dateparam"
    echo "$dateparam"
}

# @param array ( $@ unescaped -not "$@")
function main() {
    local dateparam
    local duration
    local title
    local default_duration='0045' #deprecate? leave up to calendar defaults otherwise two sources of truth.
    local dashsplit
    local start_date
    local start_time
    local end_date

    dateparam=$(get_date_param $@)
    # log_info "main."
    if [ -n "$dateparam" ]; then
        # log_info "Identifed has datespec as last param, so pop it."
        set -- "${@:1:$(($# - 1))}" # pop last param
    fi

    title=$(join '+' "$@")
    #  log_info "main. title: $title"
    if [ -z "$dateparam" ]; then
        echo "$(JSON "title" "$title")"
    else

        # Duration_spec:
        local durationsplit
        IFS='+'
        read -ra durationsplit <<<"$dateparam"
        IFS=' '

        if [ ${#durationsplit[@]} -eq 2 ]; then
            # log_info "Dur + found dateparam: $dateparam"
            dateparam=${durationsplit[0]}
            duration=${durationsplit[1]}
        fi

        # Dash => end_date or hhmm:
        IFS='-'
        read -ra dashsplit <<<"$dateparam"
        IFS=' '

        log_info "dashsplit len: ${#dashsplit[@]}"
        if [ ${#dashsplit[@]} -eq 2 ]; then
            after_dash=${dashsplit[1]}
            if [ ${#after_dash} -eq 4 ]; then
                start_time=$after_dash
            else
                end_date=$after_dash
            fi
        fi
        # startdate-starttime-endtime
        if [ ${#dashsplit[@]} -eq 3 ]; then
            start_time=${dashsplit[1]}
            end_date=${dashsplit[2]}
        fi


        #  No duration (+...) and no date-enddate then use default duration. ?deprecate? use webcal's own defaults?
        if [[ -z "$duration" && -z "$end_date" && -n "$start_time" ]]; then
            # log_info "Using default duration..."
            duration=$default_duration
        fi

        start_date=${dashsplit[0]}
        # log_info "dashsplit len: ${#dashsplit[@]} , ${dashsplit[*]}."
        # log_info "title: $title start_date: $start_date start_time: $start_time end_date: $end_date duration: $duration"

        local formatted_start_datetime
        local sd #=`echo $start_date | tr -d '/' `

        # trap for no slashes just 4 digit time, else the slash date part.
        if [ ${#start_date} -eq 4 ]; then
            st=$start_date
        else
            st=$start_time
            IFS='/'
            read -ra sa <<<"$start_date"
            IFS=' '
            sd="${sa[*]}"    #array to space delim str
            sd=${sd//' '/''} #remove spaces
            local sdlength=${#sd}
            # log_info "striped slashes"
            # log_info "sd length: $sdlength start_date: $start_date sd: "

            case $sdlength in
            1)
                #log_info "len 1: d lpad to 0d "
                sD=$(lpad "$sd" "2")
                ;;
            2)
                # log_info "len 2: dd"
                sD="$sd"
                ;;
            4)
                #log_info "len four: ddmm"
                sM=${sd:2:4}
                sD=${sd:0:2}
                ;;
            6)
                # log_info "main: six param: ddmmyy"

                sD=${sd:0:2}
                sM=${sd:2:2}
                sys_year=$(date +'%Y')
                # shim first two digits from current date
                sy=${sys_year:0:2}${sd:4:6}
                ;;
            8)
                # log_info "main: four param: ddmmyyyy"
                sy=${sd:4:8}
                sM=${sd:2:2}
                sD=${sd:0:2}
                ;;
            *) log_info "main. unhandled Error: other param length:  $sdlength, sd: $sd" ;;
            esac
        fi

        # log_info "sD:$sD sm:$sm sy:$sy st:$start_time"

        local formatted_start_datetime=$(datefmt "$sy" "$sM" "$sD" "$st")

        log_info "A: end_date: $end_date"
        if [[ -z $end_date ]]; then
            if [[ -z $duration ]]; then
                log_info "DURATION FOUND: $duration."
                # no end date, no duration : set end date to same day (without a time?)
                formatted_end_date=$formatted_start_datetime
            else
                fd=$(future_date $formatted_start_datetime "$duration")
                formatted_end_date="$fd"
            fi

        else
            formatted_end_date=$(date_api $end_date)
        fi
        # log_info "main formatted_end_date: $formatted_end_date"
         log_info "B: end_date: $end_date"
        ret=$(JSON "title" "$title" "datespec" "$formatted_start_datetime/$formatted_end_date")
        # log_info "ret: $ret"
        echo "$ret"
    fi
}
# main END

# convert sdate-start_time to y m d t. work backwards d d/m d/m/y
# at: used only by end-datespec.  should dry the code as main - has near identical block for start_date.
function date_api() {

    local start_date=$1
    local formatted_datetime
    # dt - split on slashes, replace mm /dd defaults based on param length
    local sd #=`echo $start_date | tr -d '/' `

    log_info "date_api end_date: $start_date"
    # trap for no slashes just 4 digit time, else the slash date part.
    if [ ${#start_date} -eq 4 ]; then
        st=$start_date
    else
        st=$start_time
        IFS='/'
        read -ra sa <<<"$start_date"
        IFS=' '
        sd="${sa[*]}"    #array to space delim str
        sd=${sd//' '/''} #remove spaces
        local sdlength=${#sd}
        log_info "striped slashes"

        # log_info "sd length: $sdlength start_date: $start_date sd: "
        # log_info "${sd[@]} 0:2: ${sd:0:2} 2:4: ${sd:2:4}"

        case $sdlength in
        1)
            # log_info "len 1: d lpad to 0d "
            sD=$(lpad "$sd" "2")
            ;;
        2)
            log_info "len 2: dd"
            sD="$sd"
            ;;
        4)
            # log_info "len four: ddmm"
            sM=${sd:2:4}
            sD=${sd:0:2}
            ;;
        6)
            # log_info "main: six param: ddmmyy"
            sD=${sd:0:2}
            sM=${sd:2:2}
            sys_year=$(date +'%Y')
            # shim first two digits from current date
            sy=${sys_year:0:2}${sd:4:6}
            ;;
        8)
            # log_info "main: four param: ddmmyyyy"
            sy=${sd:4:8}
            sM=${sd:2:2}
            sD=${sd:0:2}
            ;;
        *) log_info "main. other param length:  $sdlength, sd: $sd" ;;
        esac
    fi

    formatted_datetime=$(datefmt "$sy" "$sM" "$sD" "$st")
    # log_info "sD:$sD sm:$sm sy:$sy st:$start_time formatted_datetime: $formatted_datetime"
    echo "$formatted_datetime"

}

function gcal() {

    retval=$(main "$@")
    # log_info "gcal. retval: $retval"
    title=$(JSONP "title" "$retval")
    datespec=$(JSONP "datespec" "$retval")
    log_info "gcal. datespec: $datespec title: $title"

    gcalformat="https://calendar.google.com/calendar/render?action=TEMPLATE"
    local qstring=''

    if [[ -n "$datespec" ]]; then
        log_info "massage datespec"
        # append 00 (seconds?) to Times.
        local doublezero="00"
        for ((i = 0; i < ${#datespec}; i++)); do
            char="${datespec:$i:1}"
            datespec_len=${#datespec}
            if [[ $char == 'T' ]]; then
                # got T pos, substr -8 +4
                chunk="${datespec:0:$i+5}$doublezero"
                afterpart=${datespec:$i+5:$datespec_len}
                datespec="$chunk$afterpart"
                # log_info "chunk $chunk afterpart: $afterpart datespec: $datespec"
                i=$((i + 2))
            fi
        done
        qstring+="&dates=$datespec"
    fi

    [[ -n "$title" ]] && qstring+="&text=$title"

    url="$gcalformat$qstring"
    echo "$url"
    # open "$url"

}

# params: y m d t -> (blanks defaulted) => cal formatted date-time
function datefmt() {
    # pad
    local y=$1
    local m=$2
    local d=$3
    local t=$4
    : ${y:=$(date +'%Y')}
    : ${m:=$(date +'%m')}
    : ${d:=$(date +'%d')}
    # : ${t:='1200'} ditched (default time if not set)
    m=$(lpad "$m" "2")
    d=$(lpad "$d" "2")
    t=$(rpad "$t" "4")
    local T='T'
    # AT: if $t -eq '0000'
    if [ "$t" -eq '0000' ]; then
        echo "$y$m$d"
    else
        seconds="00"
        echo "$y$m$d$T$t" # $seconds" - rethink to do in gcal.
    fi
}

# duration (+...startdatespec durationdatespec)
function future_date() {
    local start_date="$1"
    local duration_date="$2"
    local d
    local m
    local y
    local hh
    local mm

    # log_info "future_date ( $1  $2 )"

    # dt denotes datetime
    local dtlength=${#duration_date}

    # log_info "dtlen: $dtlength"
    if [ ${#duration_date} -eq 4 ]; then
        hh=${duration_date:0:2}
        mm=${duration_date:2:4}
    else
        IFS='/'
        read -ra dtarr <<<"$duration_date"
        IFS=' '
        dt="${dtarr[*]}"
        local dtlength=${#dt}

        # log_info "dt length: $dtlength duration_date: $duration_date dt: "
        # log_info "0:2: ${dt:0:2} 2:4: ${dt:2:4}"

        case $dtlength in
        1)
            log_info "len 1: d lpad to 0d "
            d=$(lpad "$dt" "2")
            ;;
        2)
            log_info "len 2: dd"
            d="$dt"
            ;;
        4)
            log_info "len four: ddmm"
            d=${dt:0:2}
            mm=${dt:2:4}
            ;;
        6)
            log_info "future_date: six param: ddmmyy"

            d=${dt:0:2}
            mm=${dt:2:2}
            y=${dt:4:6}
            ;;
        8)
            log_info "future_date: four param: ddmmyyyy"
            d=${dt:0:2}
            mm=${dt:2:2}
            y=${dt:4:8}
            ;;
        *) log_error "future_date: Error - unhandled duration str length: $dtlength " ;;
        esac
    fi

    osinfo=$(uname '-s')
    if [[ "Darwin" == *"$osinfo"* ]]; then

        local vplus=""
        local sufixd='d'
        local sufixy='y'
        local sufixm='m'
        local sufixH='H'
        local sufixM='M'

        [[ -n "$y" ]] && vplus+="-v+$y$sufixy "
        [[ -n "$m" ]] && vplus+="-v+$m$sufixm "
        [[ -n "$d" ]] && vplus+="-v+$d$sufixd "

        [[ -n "$hh" && $hh != '00' ]] && vplus+="-v+$hh$sufixH "
        [[ -n "$mm" && $mm != '00' ]] && vplus+="-v+$mm$sufixM "

        if [[ $start_date == *T* ]]; then
            datetimeformat="%Y%m%dT%H%M"
        else
            datetimeformat="%Y%m%d"
        fi
        res=$(date -j $vplus -f "$datetimeformat" $start_date +"$datetimeformat")
        log_info "date -j $vplus -f $datetimeformat $start_date +$datetimeformat --> $res"

        echo "$res"
    else
        echo "TODO linux or other (date -d...)"
    fi
}
