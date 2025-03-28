using System.Web;
using System.Web.Mvc;

namespace AIMtask_Product_management
{
	public class FilterConfig
	{
		public static void RegisterGlobalFilters(GlobalFilterCollection filters)
		{
			filters.Add(new HandleErrorAttribute());
		}
	}
}
