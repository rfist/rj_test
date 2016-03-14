/**
 * Created by Vladimir on 13.03.2016.
 */
package conditions
{
	public interface ICondition
	{
		function check(user: UserModel): Boolean
		function modify(data: XML): void
		function get failReason(): String
	}
}
