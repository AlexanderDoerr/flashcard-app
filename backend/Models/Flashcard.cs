namespace backend.Models
{
    public class Flashcard : BaseEntity
    {
        public string Question { get; set; }
        public string Answer { get; set; }
        public Guid CatergoryId { get; set; }

        public Flashcard(string question, string answer)
        {
            Question = question;
            Answer = answer;
        }
    }
}