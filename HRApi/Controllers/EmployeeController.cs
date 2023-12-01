using Dapper;
using HRApi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace HRApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EmployeeController : ControllerBase
{
    // Connection string to the database
    string connectionString;
    // Constructor to initialize the controller with a configuration parameter
    public EmployeeController(IConfiguration configuration)
    {
        // Retrieve the connection string from the configuration
        connectionString = configuration.GetConnectionString("DefaultConnection"); 
    }

    [HttpGet]
    // Endpoint to retrieve all employees
    // Returns data and a status
    public ActionResult<List<Employee>> GetAllEmployees()
    {
        // Establish a connection to the database
        using SqlConnection connection = new SqlConnection(connectionString);
        // Query to get all employees from the HRAdmin.Employee table
        IEnumerable<Employee> employees = connection.Query<Employee>("SELECT * FROM HRAdmin.Employee");
        // Return Ok response with the list of employees
        return Ok(employees);
    }

    [HttpGet("{id}")]

    // Endpoint to retrieve a single employee by ID
    public ActionResult<Employee> GetEmployeeByID(int id)
    {
        // Check if the provided ID is less than 1, return BadRequest if true
         if(id < 1)
         {
            return BadRequest();
         }

         // Establish a connection to the database
         using SqlConnection connection = new SqlConnection(connectionString);

         // Query to get a single employee from the HRAdmin.Position table based on the provided ID
         Employee employee = connection.QueryFirstOrDefault<Employee>("SELECT * FROM HRAdmin.Position WHERE ID = " + id);

         // If no employee is found, return NotFound
         if(employee == null)
         {
            return NotFound();
         }
         
         // Return Ok response with the found employee
         return Ok(employee);
    }
}
