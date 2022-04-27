function dt = wy_wind_pidx2date(npd, dt0, pidx)
%WY_WIND_PIDX2DATE  Converts a raw period index to date vector
%
%   DT = WY_WIND_PIDX2DATE(NPD, DT0, PIDX)
%
%   Inputs:
%       NPD - number of periods per day (typically 24, for hourly data)
%       DT0 - 1 x 4 vector specifying initial period of raw historical data
%           (same format as DT)
%       PIDX = scalar period index for raw historical wind data
%
%   Output:
%       DT = 1 x 4 vector (YR, MO, DAY, P), specifying a specific period in
%           the raw historical wind data, where
%           YR - 4-digit year
%           MO - month-of-year (1-12)
%           DAY - day-of-month (1-31)
%           P - period of day (0-(NPD-1)) (e.g. 0-23 for hourly, i.e. NPD=24)

%   WY-Wind-Model
%   Copyright (c) 2022, Wooyoung Jeon, Ray Zimmerman
%   by Ray Zimmerman
%
%   This file is part of WY-Wind-Model.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See https://github.com/MATPOWER/wy-wind-model for more info.

%% construct date vectors for dt0 and dt
v0 = [dt0(1:3) wy_period2hms(dt0(4), npd)];
dn = datenum(v0) + (pidx-1) / npd;
v = datevec(dn);

fd = (60*(60*v(4) + v(5)) + v(6)) / (60*60*24);
dt = [v(1:3) fd*npd];


function hms = wy_period2hms(p, npd)
%% convert p to [h m s]
fd = p / npd;   %% fraction of the day
h = floor(24*fd);
m = floor(60*(24*fd - h));
s = round(60*(60*(24*fd - h) - m));
hms = [h m s];
