/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 13:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import feathers.controls.Screen;

public class SplitBill extends Screen{

    // Properties

    // Constructor
    public function SplitBill()
    {
        trace('[SplitBill]');

        createSplitBill();
    }

    // Methods
    private function createSplitBill():void
    {
    }

    private function layout():void
    {
    }

    override public function setSize(width:Number, height:Number):void
    {
        super.setSize(width,height);
        layout();
    }
}
}
