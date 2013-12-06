package be.devine.cp3.billsplit.view.pages.bills
{
import feathers.controls.Screen;

public class AddItem extends Screen
{
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
