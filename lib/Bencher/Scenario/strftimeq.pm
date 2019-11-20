package Bencher::Scenario::strftimeq;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

my @localtime = (30, 9, 11, 19, 10, 119, 2, 322, 0); #"Tue Nov 19 11:09:30 2019"

our $scenario = {
    summary => 'Benchmark strftimeq() routines',
    extra_modules => [
        'DateTime',
        'Date::DayOfWeek',
    ],
    participants => [
        {
            fcall_template => 'Date::strftimeq::strftimeq(<format>, @{<time>})',
            tags => ['Date_strftimeq'],
        },
        {
            fcall_template => 'DateTimeX::strftimeq::strftimeq(<format>, @{<time>})',
            tags => ['DateTimeX_strftimeq'],
        },
        {
            name => 'strftime',
            fcall_template => 'POSIX::strftime(<format>, @{<time>})',
            tags => ['strftime'],
        },
    ],
    datasets => [
        {
            args => {format => '%Y-%m-%d', time => \@localtime},
        },
        {
            args => {format => '%Y-%m-%d%( Date::DayOfWeek::dayofweek($_[3], $_[4]+1, $_[5]+1900) == 2 ? "tue":"" )q', time => \@localtime},
            include_participant_tags => ['Date_strftimeq'],
        },
        {
            args => {format => '%Y-%m-%d%( $_->day_of_week == 2 ? "tue":"" )q', time => \@localtime},
            include_participant_tags => ['DateTimeX_strftimeq'],
        },
    ],
};

1;
# ABSTRACT:
