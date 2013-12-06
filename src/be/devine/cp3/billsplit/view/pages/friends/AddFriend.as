/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 18:10
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.friends {
import feathers.controls.Screen;

public class AddFriend extends Screen{

    // Properties

    // Constructor
    public function AddFriend()
    {
        trace('[AddFriend]');
        createAddFriend();
    }

    // Methods

    private function createAddFriend():void
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
