package be.devine.cp3.billsplit.vo
{
public class FriendVO
{
    public var id:uint;
    public var name:String;

    public function FriendVO(){}

    public static function equals(friendVO1:FriendVO,friendVO2:FriendVO):Boolean{
        return friendVO1.id == friendVO2.id;
    }
}
}
