using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
namespace HRApi.Controllers
{
//what is a controller?
//It's just class that inherits from controllerbase
//with the route will hit this controller
//We will hit this controller with an request that goes to api/Tamplate
[Route("api/[controller]")]
[ApiController]
public class TemplateController : ControllerBase
{
    //Constructor
    public TemplateController()
    {

    }
    //methods that fire based on requests
    //GET: /api/template
    [HttpGet]

    public string Get()
    {
        return "Hello world";
    }

    //Get request with paramter
    //Get /api/template/1
    //This 1 is usually a primary key id
    //Select * from Student where id = 1

    [HttpGet("{id}")]
    public string Get(int id)
    {
        return $"Value: {id}";
    }
    //Post
    //Post is used to create a new reconrd OR send sensitive
    //Insert into student(Name, Grade) values ("Hannah", 100)
    [HttpPost]
    public void Post ([FromBody] string value)
    {
        Console.WriteLine("Post");
    }
    //Put /api/Template/1
    //This is used to update 
    //need an ID and need data from the body
    //Update Students set Name = "Kristyn" where id = 1
    [HttpPut("{id}")]
    public void Put(int id, [FromBody] string value)
    {
        Console.WriteLine("Put Request");
    }
    //Delete: /api/template/1
    //delete from student where id = 1
    [HttpDelete("{id}")]

    public void Delete(int id)
    {
        Console.WriteLine("Delete Request");
    }
}
}