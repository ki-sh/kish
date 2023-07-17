#!/bin/bash
# shellcheck disable=SC2317  # Don't warn about unreachable commands in this file due to how kit works.
# shellcheck source=somefile
source "./ocal.lib.sh" # code under test

: '
   unit and E2E`ish tests with kish kit minimal testing framework
   eg kit ocal.test.sh
'

# turn off logging
log_info "log_info turned off in ocal.test.sh"
log_info() {
   return 0
}

# -------------- HELPERS SECTION --------------------

# system dates for today:
sy=$(date +'%Y')
sd=$(date +'%d')
sm=$(date +'%m')

# helpers to test parts of datespec (useful for stability as any datetime parts not set do default to todays date)
function get_date_part() {
   local res
   local sd
   local sd=$1
   case $2 in
   'd')
      res=${sd:6:2}
      ;;
   'de')
      res=${sd:20:2}
      ;;
   'm')
      res=${sd:4:2}
      ;;
   'y')
      res=${sd:0:4}
      ;;
   't')
      res=${sd:9:4}
      ;;
   'te')
      res=${sd:23:4}
      ;;

   *) log_error "get_date_part $2 invalid param. must be d/y/m/t" ;;
   esac
   echo "$res"
}
# -------------- END HELPERS SECTION --------------------

# -------------- TESTS SECTION --------------------
desc "Duration testing"

t() {
   input="20231231T2359"
   fn=$(future_date $input "0059")
   eq " When future_date ($input '0059') give datetime 59 mins later. " "$fn" "20240101T0058"
}
it t

t() {
   input="20231231T2359"
   fn=$(future_date $input "0100")
   eq " When future_date ($input '0059') give datetime one hour later. " "$fn" "20240101T0059"
}
it t

t() {
   input="20231231T2359"
   fn=$(future_date "$input" "0100")
   # formatted_end_date=$(future_date "$formatted_start_datetime" "$duration")
   eq " When future_date ($input '0059') give datetime one hour later. " "$fn" "20240101T0059"
}
it t

desc "datetime formatting Scenarios:"
t() {
   input="31/12-2359"
   fn=$(main t i t l e $input)
   #    res=$(JSONP "datespec" "$fn")
   res=$(JSONP "datespec" "$fn")

   d=$(get_date_part "$res" 'd')
   de=$(get_date_part "$res" 'de')
   te=$(get_date_part "$res" 'te')
   echo "ocal.test res: $res"
   eq "T. ($input) given day-time when valid then set startdate and starttime and end time default 45 mins later." "$d$de$te" "31010044"
}
it t

t() {
   input="31/12-2315"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   d=$(get_date_part $res 'd')
   m=$(get_date_part $res 'm')
   t=$(get_date_part $res 't')
   echo "res: $res"
   eq "U. ($input) given day/month-time when valid then set start day" "$d$m$t" "31122315"
}
it t

t() {
   input="2358"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   t=$(get_date_part $res 't')
   echo "res: $res"
   eq "V. ($input) given 4 digit number (2 minutes to midnight) when valid then set time today" "$t" "2358"
}
it t

t() {
   input="23/12/24-2315"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   d=$(get_date_part $res 'd')
   m=$(get_date_part $res 'm')
   y=$(get_date_part $res 'y')
   t=$(get_date_part $res 't')
   echo "res: $res"

   eq "W. ($input) given day/month/year-time when valid then set start day" "$d$m$y$t" "231220242315"
}
it t

t() {
   input="24/12"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   d=$(get_date_part $res 'd')
   m=$(get_date_part $res 'm')
   #    echo "res: $res"

   eq "X. ($input) given day/month when valid then set start day and month, allday event" "$d$m" "2412"
}
it t

t() {
   input="24"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   d=$(get_date_part $res 'd')
   #    echo "res: $res"

   eq "Y. ($input) given day only when valid then set start day, allday event (no time, end_date same as start date.)" "$d" "24"
}
it t

input="25/12-31/12"
t() {
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")
   eq "Z. ($input) given date-date allday event with no time set" "$res" "20231225/20231231"
}
it t

desc "E2E google calendar"

t() {
   input="gcal start date and time NYE 29/12/2023-2359"
   fn=$(gcal $input)
   eq "gcal ($input) given gcal when fulldate-time then correctly formated gcal url " "$fn" "https://calendar.google.com/calendar/render?action=TEMPLATE&dates=20231229T235900/20231230T004400&text=gcal+start+date+and+time+NYE"
   #  open "$fn" # to manual test in browser
}
it t

t() {
   day=30
   input="gcal start day only $day"
   fn=$(gcal $input)
   eq "gcal ($input)  gcal  " "$fn" "https://calendar.google.com/calendar/render?action=TEMPLATE&dates=$sy$sm$day/$sy$sm$day&text=gcal+start+day+only"
   #  open "$fn" # to manual test in browser
}
it t

t() {
   day_month="07/07"
   input="gcal start day and month $day_month"
   fn=$(gcal $input)
   eq "gcal ($input)  gcal  " "$fn" "https://calendar.google.com/calendar/render?action=TEMPLATE&dates=20230707/20230707&text=gcal+start+day+and+month"
   #  open "$fn" # to manual test in browser
}
it t

t() {
   datespec="31/12/24-2315"
   input="gcal dmy-time $datespec"
   fn=$(gcal $input)
   eq "gcal ($input) adds default duration of 45 mins -to midnight nye " "$fn" "https://calendar.google.com/calendar/render?action=TEMPLATE&dates=20241231T231500/20250101T000000&text=gcal+dmy-time"
   #  open "$fn" # to manual test in browser
}
it t


t() {
   input="gcal no datespec just title"
   fn=$(gcal $input)
   eq "gcal ($input) leave best default time up to gcal " "$fn" "https://calendar.google.com/calendar/render?action=TEMPLATE&text=gcal+no+datespec+just+title"
   #  open "$fn" # manual test in browser
}
it t

# startdate-starttime-endtime

t() {
   input="07-2059-2130"
   fn=$(main t i t l e $input)
   res=$(JSONP "datespec" "$fn")

   d=$(get_date_part "$res" 'd')
   de=$(get_date_part "$res" 'de')
   te=$(get_date_part "$res" 'te')
   echo "ocal.test res: $res"
   eq "T. ($input)  date-time-time when valid then set startdate and starttime and end date, end time will be on same day." "$d$te" "072130"
}
it t