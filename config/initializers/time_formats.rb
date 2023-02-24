Date::DATE_FORMATS[:stamp] = "%d %B, %Y" # February 22, 2020
Date::DATE_FORMATS[:number] = "%Y-%m-%d" # YYYY-MM-DD
Date::DATE_FORMATS[:date] = "%a, %d %b %Y" # Sat, 22 Feb 2020

Time::DATE_FORMATS[:stamp] = "%B %d, %Y - %H:%M" # YYYYMMDDHHMMSS
Time::DATE_FORMATS[:date_format] = "%d %B, %Y" # YYYYMMDDHHMMSS
Time::DATE_FORMATS[:time_format] = "%H:%M" # YYYYMMDDHHMMSS
Time::DATE_FORMATS[:simple] = "%d-%m-%Y - %H:%M"
Time::DATE_FORMATS[:time] = "%H:%M"
Time::DATE_FORMATS[:date_time] = "%a, %d %b %Y-%H:%M" # Sat, 22 Feb 2020