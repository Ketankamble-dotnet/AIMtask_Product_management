using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AIMtask_Product_management.Models
{
	public class Product
	{
		public int Id { get; set; }

		[Required(ErrorMessage = "Product Name is required")]

		public string ProductName { get; set; }

		[Required(ErrorMessage = "Price is required")]
		[Range(1, double.MaxValue, ErrorMessage = "Price must be greater than 0")]
		public decimal Price { get; set; }
		[Required(ErrorMessage ="Category is required")]
		public string Category { get; set; }
		public DateTime CreatedDate { get; set; }
	}

}