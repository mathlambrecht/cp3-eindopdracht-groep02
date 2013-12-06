/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 08:45
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import feathers.controls.Screen;

public class OldBills extends Screen{

    // Properties

    // Constructor
    public function OldBills()
    {
        trace('[OldBills]');
        createOldResults();
    }

    // Methods
    private function createOldResults():void
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
