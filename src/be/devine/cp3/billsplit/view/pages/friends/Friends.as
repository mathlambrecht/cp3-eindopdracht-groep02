/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 16:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.friends {
import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;

public class Friends extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    // Constructor
    public function Friends()
    {
        trace('[Friends]');
    }

    // Methods
    override protected function initialize():void
    {
    }

    override protected function draw():void
    {
        super.draw();
    }
}
}
