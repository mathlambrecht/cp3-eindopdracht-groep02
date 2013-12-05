package {

import be.devine.cp3.billsplit.Application;

import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import starling.core.Starling;

public class Main extends MovieClip
{
    // Properties
    private var _app:Starling;

    // Constructor
    public function Main()
    {
        trace('[Main]');

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        _app = new Starling(Application, stage);
        _app.start();
    }

    // Methods

}
}
