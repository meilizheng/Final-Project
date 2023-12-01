namespace HRApi.Models;
//Models are just C# representation of a table in a database
public class Employee
{
    public int EmployeeId {get; set;}
    //prop tab 
    public string Name { get; set; }
    //prop tab datatype tab tab type the columname
    public string Email { get; set; }
    public string Phone { get; set; }
}