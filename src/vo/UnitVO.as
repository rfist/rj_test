package vo
{
	public class UnitVO
	{
		private var _type: String;
		private var _level: int;
		public function UnitVO(dataXML :XML)
		{
			_type = dataXML.@type;
			_level = dataXML.@level;
		}
		
		public function get level(): int
		{
			return _level;
		}
		
		public function get type(): String
		{
			return _type;
		}
		
	}
}