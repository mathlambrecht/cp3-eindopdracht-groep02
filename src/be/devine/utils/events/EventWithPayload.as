/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 17/04/13
 * Time: 17:47
 * To change this template use File | Settings | File Templates.
 */
package be.devine.utils.events {
import flash.events.Event;

public class EventWithPayload extends Event{

    public var payload:Object;

    public function EventWithPayload(type:String, payload:Object, bubbles:Boolean = false, cancelable:Boolean = true) {
        super(type, bubbles, cancelable);
        this.payload = payload;
    }

    override public function clone():Event
    {
        return new EventWithPayload(type, payload, bubbles, cancelable);
    }
}
}
