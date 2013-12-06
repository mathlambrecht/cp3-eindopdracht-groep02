/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 18:11
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import feathers.controls.Screen;

public class AddItem extends Screen{

    // Properties

    // Constructor
    public function AddItem()
    {
        trace('[AddItem]');
        createAddItem();
    }

    // Methods
    private function createAddItem():void
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
