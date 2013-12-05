/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view {
import be.devine.cp3.billsplit.view.pages.Home;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import starling.display.Sprite;

public class Content extends Sprite{

    // Properties
    private var _navigator:ScreenNavigator;

    // Constructor
    public function Content()
    {
        trace('[Content]');

        // screenNavigator
        _navigator = new ScreenNavigator();
        _navigator.addScreen( "home", new ScreenNavigatorItem(Home) );
        addChild(_navigator);

        _navigator.showScreen( "home" );
    }

    // Methods
    public function setSize(width:Number,height:Number):void{
        this.width = width;
        this.height = height;
    }
}
}
