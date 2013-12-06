/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 17:01
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import feathers.controls.Screen;

public class Results extends Screen{

    // Properties

    // Constructor
    public function Results()
    {
        trace('[Results]');
        createResults();
    }

    // Methods
    private function createResults():void
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
