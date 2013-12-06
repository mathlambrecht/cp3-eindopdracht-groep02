/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import feathers.controls.Screen;

public class BillFriends extends Screen{

    // Properties

    // Constructor
    public function BillFriends()
    {
        trace('[BillFriends]');

        createBillFriends();
    }

    // Methods
    private function createBillFriends():void
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
