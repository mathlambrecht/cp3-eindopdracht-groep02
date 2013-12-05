/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 11/04/13
 * Time: 15:36
 * To change this template use File | Settings | File Templates.
 */
package be.devine.math {
import flash.display.DisplayObject;
import flash.geom.Point;

public class MathUtilities {

    public static function convertDegreesToRadians(degrees:Number):Number{

        return ((Math.PI)/180)*degrees;
    }

    public static function convertRadianstoDegrees(radians:Number):Number{

        return (180/(Math.PI))*radians;
    }

    public static function calculateDistance(object1:DisplayObject, object2:DisplayObject):Number{

        return Math.sqrt(Math.pow(object1.x - object2.x, 2) + Math.pow(object1.y - object2.y, 2));
    }

    public static function interpolate( normValue:Number, minimum:Number, maximum:Number ):Number
    {
        return minimum + (maximum - minimum) * normValue;
    }

    public static function map( value:Number, min1:Number, max1:Number, min2:Number, max2:Number ):Number
    {
        return interpolate( normalize( value, min1, max1 ), min2, max2 );
    }

    public static function normalize( value:Number, minimum:Number, maximum:Number ):Number
    {
        return (value - minimum) / (maximum - minimum);
    }

    public static function convertCartCoToPolCo(x:Number, y:Number):Array{

        var r:Number = Math.sqrt(Math.pow(x,2) + Math.pow(x,2));
        var angle:Number = Math.atan(r/y);

        return new Array(r, angle);
    }

    public static function convertPolCoToCartCo(r:Number, angle:Number):Point{

        return new Point(r * Math.cos(angle), r * Math.sin(angle));
    }

    // GONIOMETRIC FORMULAS

    public static function superformula(a:Number, b:Number, m:Number, n1:Number, n2:Number, n3:Number, scale:Number, p:Number):Point{

        var ang:Number = m * p / 4;
        var r:Number = Math.pow( Math.pow( Math.abs( Math.cos(ang) / a), n2) + Math.pow( Math.abs( Math.sin(ang) / b), n3), -1/n1);

        var xp:Number = r * Math.cos(p);
        var yp:Number = r * Math.sin(p);

        return new Point(xp*scale, yp*scale);
    }

    public static function roset(a:Number, m:Number, scale:Number, p:Number):Point{

        var r:Number = -a * Math.cos(m * p);

        var xp:Number = r * Math.cos(p);
        var yp:Number = r * Math.sin(p);

        return new Point(xp*scale, yp*scale);
    }

    public static function cardioid(a:Number, scale:Number, p:Number):Point{

        var r:Number = a * (1 + Math.cos(p));

        var xp:Number = r * Math.cos(p);
        var yp:Number = r * Math.sin(p);

        return new Point(xp*scale, yp*scale);
    }

    public static function hypotrochoid(a:Number, b:Number,h:Number, scale:Number, p:Number):Point{

        // to do: r

        var xp:Number = (a-b)*Math.cos(p)+h*Math.cos(((a-b)/b)*p);
        var yp:Number = (a-b)*Math.sin(p)-h*Math.sin(((a-b)/b)*p);

        return new Point(xp*scale, yp*scale);
    }

    public static function spiral(a:Number, scale:Number, p:Number):Point{

        var r:Number =  a * p;

        var xp:Number = r * Math.cos(p);
        var yp:Number = r * Math.sin(p);

        return new Point(xp*scale, yp*scale);
    }
}
}