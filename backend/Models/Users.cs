namespace backend.Models
{
    public class Users : BaseEntity
    {
        public string Name { get; set; }
        public string Email { get; set; }

        public Users(string name, string email)
        {
            Name = name;
            Email = email;
        }
    }
}
