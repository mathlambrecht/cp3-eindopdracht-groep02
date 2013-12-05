package {

import be.devine.cp3.billsplit.Application;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;

public class Main extends MovieClip
{
    // Properties
    private var _app:Starling;

    // Constructor
    public function Main()
    {
<<<<<<< HEAD
        trace('[Main]');

=======
        stage.scaleMode = StageScaleMode.NO_SCALE;
>>>>>>> 33966be743ae85a3c9507a4158c06ed19a3657ba
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _app = new Starling(Application, stage);
        _app.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }
<<<<<<< HEAD

    // Methods

    private function resizeHandler(event:flash.events.Event):void
    {
        trace('[Main] Resize');

        _app.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _app.stage.stageWidth = stage.stageWidth;
        _app.stage.stageHeight = stage.stageHeight;
        _app.stage.dispatchEvent(new starling.events.Event(starling.events.Event.RESIZE));
    }

=======
>>>>>>> 33966be743ae85a3c9507a4158c06ed19a3657ba
}
}
