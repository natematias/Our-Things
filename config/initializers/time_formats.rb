Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.localtime.strftime("%H:%M%p, %b #{time.day.ordinalize}") }

