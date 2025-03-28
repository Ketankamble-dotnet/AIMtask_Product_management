using AIMtask_Product_management.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

public class ProductAPIController : ApiController
{
	private string connectionString = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

	[HttpGet]
	[Route("api/product/getall")]
	public IHttpActionResult GetAllProducts()
	{
		List<Product> products = new List<Product>();
		using (SqlConnection conn = new SqlConnection(connectionString))
		{
			SqlCommand cmd = new SqlCommand("SP_ManageProduct", conn);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.AddWithValue("@Flag", "SELECT");
			conn.Open();
			SqlDataReader reader = cmd.ExecuteReader();
			while (reader.Read())
			{
				products.Add(new Product
				{
					Id = Convert.ToInt32(reader["Id"]),
					ProductName = reader["ProductName"].ToString(),
					Price = Convert.ToDecimal(reader["Price"]),
					Category = reader["Category"].ToString(),
					CreatedDate = Convert.ToDateTime(reader["CreatedDate"])
				});
			}
		}
		return Ok(products);
	}

	[HttpPost]
	[Route("api/product/add")]
	public IHttpActionResult AddProduct(Product product)
	{
		if (product == null || string.IsNullOrWhiteSpace(product.ProductName) || product.Price <= 0 || string.IsNullOrWhiteSpace(product.Category))
		{
			return BadRequest("Invalid input: Product Name, Price, and Category are required, and Price must be greater than zero.");
		}

		try
		{
			using (SqlConnection conn = new SqlConnection(connectionString))
			{
				SqlCommand cmd = new SqlCommand("SP_ManageProduct", conn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.AddWithValue("@Flag", "INSERT");
				cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
				cmd.Parameters.AddWithValue("@Price", product.Price);
				cmd.Parameters.AddWithValue("@Category", product.Category);
				conn.Open();
				cmd.ExecuteNonQuery();
			}
			return Ok(new { message = "Product added successfully" });
		}
		catch (Exception ex)
		{
			return BadRequest("Error: " + ex.Message);
		}
	}

	[HttpPut]
	[Route("api/product/update")]
	public IHttpActionResult UpdateProduct(Product product)
	{
		if (product == null || product.Id <= 0 || string.IsNullOrWhiteSpace(product.ProductName) || product.Price <= 0 || string.IsNullOrWhiteSpace(product.Category))
		{
			return BadRequest("Invalid input: Product ID, Name, Price, and Category are required, and Price must be greater than zero.");
		}

		try
		{
			using (SqlConnection conn = new SqlConnection(connectionString))
			{
				SqlCommand cmd = new SqlCommand("SP_ManageProduct", conn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.AddWithValue("@Flag", "UPDATE");
				cmd.Parameters.AddWithValue("@Id", product.Id);
				cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
				cmd.Parameters.AddWithValue("@Price", product.Price);
				cmd.Parameters.AddWithValue("@Category", product.Category);
				conn.Open();
				cmd.ExecuteNonQuery();
			}
			return Ok(new { message = "Product updated successfully" });
		}
		catch (Exception ex)
		{
			return BadRequest("Error: " + ex.Message);
		}
	}

	[HttpDelete]
	[Route("api/product/delete/{id}")]
	public IHttpActionResult DeleteProduct(int id)
	{
		if (id <= 0)
		{
			return BadRequest("Invalid Product ID.");
		}

		try
		{
			using (SqlConnection conn = new SqlConnection(connectionString))
			{
				SqlCommand cmd = new SqlCommand("SP_ManageProduct", conn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.AddWithValue("@Flag", "DELETE");
				cmd.Parameters.AddWithValue("@Id", id);
				conn.Open();
				cmd.ExecuteNonQuery();
			}
			return Ok(new { message = "Product deleted successfully" });
		}
		catch (Exception ex)
		{
			return BadRequest("Error: " + ex.Message);
		}
	}
}
