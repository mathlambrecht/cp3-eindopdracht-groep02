/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view {
import starling.display.Quad;
import starling.display.Sprite;

public class Header extends Sprite {

    // Properties
    private var _background:Quad;

    // Constructor
    public function Header()
    {
        trace('[Header]');

        createHeader();
    }

    // Methods
    private function createHeader():void
    {

    }

    public function setSize(width:Number,height:Number):void
    {
        _background = new Quad(width,height,0x000000);
        addChild(_background);

    }
}
}
