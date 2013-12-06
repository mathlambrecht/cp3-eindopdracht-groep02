/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import feathers.controls.Screen;

public class BillItems extends Screen{

    //Properties

    // Constructor
    public function BillItems()
    {
        trace('[BillItems]');
        createBillItems();
    }

    // Methods
    private function createBillItems():void
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
