﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace AIMtask_Product_management
{
	public class MvcApplication : System.Web.HttpApplication
	{
		protected void Application_Start()
		{
			
			
				AreaRegistration.RegisterAllAreas();
				GlobalConfiguration.Configure(WebApiConfig.Register);  
				RouteConfig.RegisterRoutes(RouteTable.Routes);  
				FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
				BundleConfig.RegisterBundles(BundleTable.Bundles);
		

		}
	}
}
