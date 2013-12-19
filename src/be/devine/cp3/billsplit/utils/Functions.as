/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 14/12/13
 * Time: 22:33
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.utils {
import be.devine.cp3.billsplit.vo.FriendItemVO;
import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.ItemVO;

public class Functions {

    public function Functions() {}

    public static function equals(friendVO1:FriendVO,friendVO2:FriendVO):Boolean
    {
        return friendVO1.id == friendVO2.id;
    }

    public static function equalsFriendItem(friendItemVO1:FriendItemVO,friendItemVO2:FriendItemVO):Boolean
    {
        return ((friendItemVO1.idFriend == friendItemVO2.idFriend) && (friendItemVO1.idItem == friendItemVO2.idItem));
    }
}
}
