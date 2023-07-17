#!/usr/bin/env bash
# source "$HOME/ocal.lib.sh"
source "/Users/henrykemp/.kish/ocal.lib.sh"
source "$HOME/.kish/lib/klog.sh"

 st="ocal"
 cmd="google calendar event fast"
if [ $# -eq 0 ] || [ "$1" = '-h' ]; then  
    echo "                  *******************************************"
    echo "                  *   ocal - lightning fast event creation. *"  
    echo "                  *******************************************"
    echo
    echo "  Intro: ocal is designed to be most human, intuitive, minimal way of entering events with dates/times/durations/ranges."
    echo " All you need to know is simple rules: .  or date-date range."
    echo " Times are given as 4 digits."
    echo " A dash separates date-time or date-enddate"
    echo " Use a second dash to give endtime."
    echo " Dates can be a day on its own (one or two digits), day/month or day/month/year."
    echo " No dates given then it defaults to today. "
    echo " + for a duration. duration uses the same date - time format as above."
    echo
    echo "  The datetime goes after the title eg: ocal my event title 25/12"
    echo " ocal will open default web browser with (currently google calendar) with the title, dates/times/duration/all day set."  
    echo " Customise/tweek event from there. Waaaay faster than clicking about with a mouse in the web page :)"
    echo " So dive in and have a play - try this first: "
    echo " ocal Open Christmas presents, all 50 25/12-0945-1038 "
    echo
    echo "  Quick datetime reference: "
    echo "  d                       # single number for a day"
    echo "  dd                      # two digts -still just day"
    echo "  dd/mm                   # day and month (this year) "
    echo "  dd/mm/yy                # specfic date"
    echo "  hhmm                    # at a time today"
    echo "  dd/mm/yy-hhmm           # specific date-time"
    echo "  dd-hhmm-hhmm            # specific date-time-endtime"
    echo "  +hhmm                    # duration eg 0010 is ten mins. "
    echo "  +dd/mm/yy                # duration -add days/months/years "
    echo "  dd/mm/yy-dd/mm/yy        # date range "
    echo "  01/01/2111-1111          # title is optional      "
    echo "  title only               # datespec is optional    "
    echo "  $> ocal - h   or just $> ocal     - shows this help and calendar"
   
    # echo
    # echo "  ocal whatever title you want.                # no datetime. No need to surround title with quotes"
    # echo "  ocal 27/12                                    # just a date/time title not required"
    # echo "  ocal at day/month 26/12                       # no time specified so all day event"
    # echo "  ocal an event title on day 28                 # if the last paramater has number it specifes the date and or time."
    echo
    echo "  Examples:"
    echo "  ocal My event title 25/12-1015                # commonest usecase day month -time. time is always 4 digits hhmm with no : between hhmm"
    echo "  ocal 25/12-1015+0115                          # +hhmm  duration time. here its 1hr 15 mins."
    echo "  ocal xmas hols 25/12+7                        # +n  duration days. No time specified so 'all day' event for 7 days"
    echo "  ocal day range 24/12-03/01/24                 # range from date - to date."
    echo ""
    echo "  Note for google calendar api +days or date-range, is up to the day before that given. Can just add another day /specify the day after."
    echo
    echo "3 month calendar:"
    cal -A 2
else
    # turn off logging
    log_info () { 
        return 0 
    }
    res=$(gcal "$@")
    open "$res"
fi
klog "ocal $*"
