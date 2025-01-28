namespace backend.Models
{
    public class Categories : BaseEntity
    {
        public string Name { get; set; }

        public Categories(string name)
        {
            Name = name;
        }
    }
}
