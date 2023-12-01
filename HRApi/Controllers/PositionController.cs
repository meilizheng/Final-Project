using Dapper;
using HRApi.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace HRApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PositionController : ControllerBase
{
    // Connection string to the database
    string connectionString;
    
    // Constructor to initialize the controller with a configuration parameter
    public PositionController(IConfiguration configuration)
    {
        // Retrieve the connection string from the configuration
        connectionString = configuration.GetConnectionString("DefaultConnection"); 
    }

    [HttpGet]
    // Endpoint to retrieve all positions
    // Returns data and a status
    public ActionResult<List<Position>> GetAllPositions()
    {
        // Establish a connection to the database
        using SqlConnection connection = new SqlConnection(connectionString);
        // Query to get all positions from the HRAdmin.Position table
        IEnumerable<Position> positions = connection.Query<Position>("SELECT * FROM HRAdmin.Position");
        // Return Ok response with the list of positions
        return Ok(positions);
    }

    [HttpGet("{id}")]
    // Endpoint to retrieve a single position by ID
    public ActionResult<Position> GePositionByID(int id)
    {
         using SqlConnection connection = new SqlConnection(connectionString);
         //what do we want back just 1 employee
         Position position = connection.QueryFirstOrDefault<Position>("SELECT * FROM HRAdmin.Position WHERE ID = @Id", new {id = id});
         // Check if the provided ID is less than 1, return NotFound if true
         if(position == null)
         {
            return NotFound();
         }
         return Ok(position);
    }

    [HttpPost]
    public ActionResult<Position> CreatePosition(Position position)
    {
        // Establish a connection to the database
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            try
            {
                // Query to get a single position from the HRAdmin.Position table based on the provided ID
                Position Newposition = connection.QuerySingle<Position>("INSERT INTO HRAdmin.Position (Name) VALUES (@Name); SELECT * FROM HRAdmin.Position WHERE ID = SCOPE_IDENTITY();", position);
                return Ok(Newposition);
            }
            catch (Exception ex)
            {
                // Log the exception and return BadRequest if an error occurs during the creation of the position
                Console.WriteLine(ex);
                return BadRequest();
            }
            
        }
    }

    // Endpoint to update an existing position by ID
    [HttpPut("{id}")]
        public ActionResult<Position> UpdatePosition(int id, Position position)
        {
            // Check if the provided ID is less than 1, return NotFound if true
            if(id < 1)
            {
                return NotFound();
            }
            // Set the ID of the position to be updated
            position.ID = id;

            // Establish a connection to the database
            using SqlConnection connection = new SqlConnection(connectionString);

            // Updating the position in the database
            int rowsAffected = connection.Execute("UPDATE HRAdmin.Position SET NAME = @Name WHERE ID = @ID", position);

            // If no rows were affected, return BadRequest
            if(rowsAffected == 0)
            {
                return BadRequest();
            }

            // Return Ok response with the updated position
            return Ok(position);
        }

       //Delete
       [HttpDelete("{id}")]
       // Endpoint to delete a position by ID
        public ActionResult DeletePosition(int id)
        {
            // Check if the provided ID is less than 1, return NotFound if true
            if (id < 1)
            {
             return NotFound();
            }

           // Establish a connection to the database
           using (SqlConnection connection = new SqlConnection(connectionString))
           {
            // Deleting the position from the database
            int rowsAffected = connection.Execute("DELETE FROM HRAdmin.Position WHERE ID = @Id", new { Id = id });

           // If no rows were affected, return NotFound with a meaningful message
           if (rowsAffected == 0)
           {
             return NotFound($"No position found for the provided ID {id}."); // Returning NotFound if no rows were affected
           }

        // Return Ok response if the position is successfully deleted
        return Ok(); 
    }
}
}