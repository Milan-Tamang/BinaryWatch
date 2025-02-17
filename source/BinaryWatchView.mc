import Toybox.Lang;
import Toybox.System;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class BinaryWatchView extends WatchUi.WatchFace {
    // used to hide elements when in low power mode
    var isAwake;

    function initialize()
    {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void
    {
        isAwake = true;
    }

    // don't look at this..
    function toBin(num)
    {
        var binOut = "";

        switch(num)
        {
            case 0:
                binOut = "000000";
                break;
            case 1:
                binOut = "000001";
                break;
            case 2:
                binOut = "000010";
                break;
            case 3:
                binOut = "000011";
                break;
            case 4:
                binOut = "000100";
                break;
            case 5:
                binOut = "000101";
                break;
            case 6:
                binOut = "000110";
                break;
            case 7:
                binOut = "000111";
                break;
            case 8:
                binOut = "001000";
                break;
            case 9:
                binOut = "001001";
                break;
            case 10:
                binOut = "001010";
                break;
            case 11:
                binOut = "001011";
                break;
            case 12:
                binOut = "001100";
                break;
            case 13:
                binOut = "001101";
                break;
            case 14:
                binOut = "001110";
                break;
            case 15:
                binOut = "001111";
                break;
            case 16:
                binOut = "010000";
                break;
            case 17:
                binOut = "010001";
                break;
            case 18:
                binOut = "010010";
                break;
            case 19:
                binOut = "010011";
                break;
            case 20:
                binOut = "010100";
                break;
            case 21:
                binOut = "010101";
                break;
            case 22:
                binOut = "010110";
                break;
            case 23:
                binOut = "010111";
                break;
            case 24:
                binOut = "011000";
                break;
            case 25:
                binOut = "011001";
                break;
            case 26:
                binOut = "011010";
                break;
            case 27:
                binOut = "011011";
                break;
            case 28:
                binOut = "011100";
                break;
            case 29:
                binOut = "011101";
                break;
            case 30:
                binOut = "011110";
                break;
            case 31:
                binOut = "011111";
                break;
            case 32:
                binOut = "100000";
                break;
            case 33:
                binOut = "100001";
                break;
            case 34:
                binOut = "100010";
                break;
            case 35:
                binOut = "100011";
                break;
            case 36:
                binOut = "100100";
                break;
            case 37:
                binOut = "100101";
                break;
            case 38:
                binOut = "100110";
                break;
            case 39:
                binOut = "100111";
                break;
            case 40:
                binOut = "101000";
                break;
            case 41:
                binOut = "101001";
                break;
            case 42:
                binOut = "101010";
                break;
            case 43:
                binOut = "101011";
                break;
            case 44:
                binOut = "101100";
                break;
            case 45:
                binOut = "101101";
                break;
            case 46:
                binOut = "101110";
                break;
            case 47:
                binOut = "101111";
                break;
            case 48:
                binOut = "110000";
                break;
            case 49:
                binOut = "110001";
                break;
            case 50:
                binOut = "110010";
                break;
            case 51:
                binOut = "110011";
                break;
            case 52:
                binOut = "110100";
                break;
            case 53:
                binOut = "110101";
                break;
            case 54:
                binOut = "110110";
                break;
            case 55:
                binOut = "110111";
                break;
            case 56:
                binOut = "111000";
                break;
            case 57:
                binOut = "111001";
                break;
            case 58:
                binOut = "111010";
                break;
            case 59:
                binOut = "111011";
                break;
            default:
                binOut = "";
                break;
        }

        return binOut;
    }

    // much better implementation for binary conversion
    function toBin2(num)
    {
        var binOut = "";
        var i = 6;

        while(num > 0)
        {
            binOut = ((num % 2) == 0 ? "0" : "1") + binOut;
            num /= 2;
            i--;
        }

        while(i > 0)
        {
            binOut = "0" + binOut;
            i--;
        }

        return binOut;
    }

    function showTime()
    {
        // get hour and minutes
        var clockTime = System.getClockTime();

        // hour
        var HrString = clockTime.hour;
        var viewTimeHr = View.findDrawableById("TimeHr") as Text;
        var binHr = toBin2(HrString);
        viewTimeHr.setText(binHr);

        // minutes
        var MinString = clockTime.min;
        var viewTimeMin = View.findDrawableById("TimeMin") as Text;
        var binMin = toBin2(MinString);
        viewTimeMin.setText(binMin);

        // seconds (only visible while in high power mode)
        var secString = clockTime.sec;
        var viewTimeSec = View.findDrawableById("TimeSec") as Text;
        var binSec = isAwake ? toBin2(secString) : "";
        viewTimeSec.setText(binSec);

        // DEBUG
        // System.print(secString);
        // System.print(" -> ");
        // System.println(binSec);

        // System.print("secString:\t");
        // System.println(secString);
        // System.print("MinHrString:\t");
        // System.println(MinHrString);
    }

    function showDate()
    {
        // date
        var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$",
        [
            date.day_of_week,
            date.day.format("%02d"),
            date.month
        ]);

        var viewDate = View.findDrawableById("Date") as Text;
        viewDate.setText(isAwake ? dateString : "");

        // DEBUG
        // System.print("dateString:\t");
        // System.println(dateString);
    }

    function showBattery()
    {
        // battery charge
        var systemStats = System.getSystemStats();
        var batteryPercent = systemStats.battery;

        // todo: if battery below 20% always show on display

        var batteryString = (!isAwake && batteryPercent > 20 ) ? "": (batteryPercent.format("%d") + "%");
        // if NOT awake and batteryPercent > 20
        // then: show nothing
        // else if awake AND batteryPercent > OR < 20: show battery
        var viewBattery = View.findDrawableById("Battery") as Text;
        var viewBatteryLOW = View.findDrawableById("BatteryLOW") as Text;

        if(batteryPercent <= 20)
        {
            viewBatteryLOW.setText(batteryString);
            viewBattery.setText("");

            // DEBUG
            // System.println("battery <= 20");
        }
        else
        {
            viewBattery.setText(batteryString);
            viewBatteryLOW.setText("");

            // DEBUG
            // System.println("battery > 20");
        }

        // DEBUG
        // System.print("batteryString:\t");
        // System.println(batteryString);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void
    {
        // display time
        showTime();

        // display date
        showDate();

        // display battery
        showBattery();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {}

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void
    {
        isAwake = true;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void
    {
        isAwake = false;
    }
}