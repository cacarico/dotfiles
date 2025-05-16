#!/usr/bin/env fish

pkill -9 polybar

while pgrep -u $USER -x polybar >/dev/null
    sleep 1
end
# polybar main 2>&1 | tee -a /tmp/polybar_top.log & disown

if test (autorandr --current) = carbon-solo
    polybar carbon-solo 1>&1 | tee -a /tmp/polybar_carbon-home-1.log & disown
end

if test (autorandr --current) = think
    polybar think 1>&1 | tee -a /tmp/polybar_think.log & disown
end

if test (autorandr --current) = think-home-2
    polybar carbon-think-1 >&1 | tee -a /tmp/polybar_carbon-home-1.log & disown
    polybar carbon-think-2 >&1 | tee -a /tmp/polybar_carbon-home-2.log & disown
    polybar carbon-think-3 >&1 | tee -a /tmp/polybar_carbon-home-3.log & disown
end

# Carbon Office 3 screens
if test (autorandr --current) = carbon-office-2
    polybar carbon-office-1 >&1 | tee -a /tmp/polybar_think-office-1.log & disown
    polybar carbon-office-2 >&1 | tee -a /tmp/polybar_think-office-2.log & disown
    polybar carbon-office-3 >&1 | tee -a /tmp/polybar_think-office-3.log & disown
end

# Carbon Home 3S
if test (autorandr --current) = carbon-home-2
    polybar carbon-home-1 >&1 | tee -a /tmp/polybar_carbon-home-1.log & disown
    polybar carbon-home-2 >&1 | tee -a /tmp/polybar_carbon-home-2.log & disown
    polybar carbon-home-3 >&1 | tee -a /tmp/polybar_carbon-home-3.log & disown
end

# Carbon Home 2S
if test (autorandr --current) = carbon-home-1
    polybar carbon-home-1 1>&1 | tee -a /tmp/polybar_carbon-home-1.log & disown
    polybar carbon-home-2 1>&1 | tee -a /tmp/polybar_carbon-home-2.log & disown
end

# Thinkpad Solo
if test (autorandr --current) = think-solo
    polybar think-solo 1>&1 | tee -a /tmp/polybar_carbon-home-1.log & disown
end

# Thinkpad Solo
if test (autorandr --current) = think-home-2
    polybar think-home-0 1>&1 | tee -a /tmp/polybar_think-home-0.log & disown
    polybar think-home-1 1>&1 | tee -a /tmp/polybar_think-home-1.log & disown
    polybar think-home-2 1>&1 | tee -a /tmp/polybar_think-home-2.log & disown
end

echo "Bars launched..."
